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
    func requestThreads(departureId: String,
                        arrivalId: String,
                        date: String,
                        transport: TransportType?,
                        completion: @escaping (Result<ThreadList,
                                               YandexAPIError>) -> Void)
}

final class YandexAPIManager: YandexAPIManagerProtocol {
    func requestThreads(departureId: String,
                        arrivalId: String,
                        date: String,
                        transport: TransportType?,
                        completion: @escaping (Result<ThreadList,
                                               YandexAPIError>) -> Void) {
        let getThreadsRequest = YandexAPIRoute.getThreads(departureId: departureId,
                                                          arrivalId: arrivalId,
                                                          date: date,
                                                          transport: transport)
        getThreadsRequest.asURLRequest { result in
            switch result {
            case .success(let request):
                AF.request(request).validate().responseDecodable(of: ThreadList.self) { response in
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
   
    func requestStations(completion:@escaping (Result<StationList,
                                               YandexAPIError>) -> Void) {
        let getStationsRequest = YandexAPIRoute.getStations
        getStationsRequest.asURLRequest { result in
            switch result {
            case .success(let request):
                AF.request(request).validate().responseDecodable(of: StationList.self) { response in
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
