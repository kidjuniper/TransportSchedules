//
//  DefaultRequestAdapter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import Alamofire

final class DefaultRequestAdapter: RequestAdapter {
    private let token: String = "525325cf-b076-4540-b378-7d10f0b9519d"
    private let authHeader: String = "Authorization"
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest,
                                      Error>) -> Void) {
        var request = urlRequest
        request.setValue(token,
                         forHTTPHeaderField: self.authHeader)
        completion(.success(request))
    }
}
