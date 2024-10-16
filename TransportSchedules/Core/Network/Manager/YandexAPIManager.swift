//
//  YandexAPIManager.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import Alamofire

protocol YandexAPIManagerProtocol {
    func requestStations(completion: @escaping (Result<StationList,
                                                YandexAPIError>) -> Void)
}

final class YandexAPIManager: YandexAPIManagerProtocol {
    let getStationsRequest = YandexAPIRoute.getStations
    func requestStations(completion:@escaping (Result<StationList,
                                               YandexAPIError>) -> Void) {
        getStationsRequest.asURLRequest { result in
            switch result {
            case .success(let request):
                AF.request(request).responseDecodable(of: StationList.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure:
                        completion(.failure(.invalidJSON))
                    }
                }
            case .failure:
                completion(.failure(.failedRequest))
            }
        }
    }
}

enum YandexAPIError: Error {
    case failedRequest
    case invalidJSON
}
