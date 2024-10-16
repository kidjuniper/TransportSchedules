//
//  DefaultCodable.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

public protocol DefaultCodableStrategy {
    associatedtype RawValue: Codable
    
    static var defaultValue: RawValue { get }
}

// MARK: - `@Defaultable` attempts to decode a value and falls back to a default type provided by the generic `DefaultCodableStrategy`.
@propertyWrapper
public struct DefaultCodable<Default: DefaultCodableStrategy>: Codable {
    public var wrappedValue: Default.RawValue
    
    public init(wrappedValue: Default.RawValue) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            wrappedValue = try container.decode(Default.RawValue.self)
        } catch {
            wrappedValue = Default.defaultValue
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultCodable: Equatable where Default.RawValue: Equatable { }
extension DefaultCodable: Hashable where Default.RawValue: Hashable { }

// MARK: - KeyedDecodingContainer
public extension KeyedDecodingContainer {
    func decode<P>(_: DefaultCodable<P>.Type,
                   forKey key: Key) throws -> DefaultCodable<P> {
        if let value = try decodeIfPresent(DefaultCodable<P>.self,
                                           forKey: key) {
            return value
        } else {
            return DefaultCodable(wrappedValue: P.defaultValue)
        }
    }
}

// MARK: - Default Typealias
public struct DefaultEmptyArrayStrategy<T: Codable>: DefaultCodableStrategy {
    public static var defaultValue: [T] { return [] }
}
public typealias DefaultEmptyArray<T> = DefaultCodable<DefaultEmptyArrayStrategy<T>> where T: Codable

public struct DefaultEmptyStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}
public typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>

public struct DefaultDoubleStrategy: DefaultCodableStrategy {
    public static var defaultValue: Double { return 0.0 }
}
public typealias DefaultDouble = DefaultCodable<DefaultDoubleStrategy>

// For Structs and Classes with default init():
public protocol DefaultInitializable: Codable {
    init()
}
public struct DefaultEmptyEntityStrategy<T: Codable & DefaultInitializable>: DefaultCodableStrategy {
    public static var defaultValue: T { return T() }
}
public typealias DefaultEmptyEntity<T: DefaultInitializable> = DefaultCodable<DefaultEmptyEntityStrategy<T>>
