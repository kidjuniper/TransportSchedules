//
//  ExtendedRequest.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import Alamofire

public typealias ExtendedRequest = NetworkRequestParams & URLRequestConvertible

public protocol NetworkRequestParams {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension NetworkRequestParams {
    public var baseUrl: URL {
        return URL(string: "https://api.rasp.yandex.net/v3.0")!
    }
    
    public var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}

extension URLRequestConvertible where Self: NetworkRequestParams {
    // MARK: - required one
    public func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var request = try URLRequest(url: url,
                                     method: method)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 30
        return request
    }
    
    // MARK: - with adapter
    public func asURLRequest(completion: @escaping (Result<URLRequest,
                                                     Error>) -> Void) {
        let url = "\(baseUrl)\(path)"
         var request: URLRequest
         
         do {
             request = try URLRequest(url: url,
                                      method: method)
             request.cachePolicy = .reloadIgnoringLocalCacheData
             request.timeoutInterval = 30
             
         } catch {
             completion(.failure(error))
             return
         }
         
         let tokenAdapter = DefaultRequestAdapter()
         
         tokenAdapter.adapt(request,
                            for: .default) { result in
             switch result {
             case .success(let modifiedRequest):
                 completion(.success(modifiedRequest))
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }
}
