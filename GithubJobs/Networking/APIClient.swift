//
//  APIClient.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation
import Combine

protocol APIClient {

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?) -> AnyPublisher<T, APIError>

}

extension APIClient {

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                             decodingType: T.Type) -> AnyPublisher<Decodable, Error> {
        session.dataTaskPublisher(for: request)
            .tryMap { result -> Decodable in
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.requestFailed }
                guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else { throw APIError(response: httpResponse) }
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(decodingType, from: result.data)
                return genericModel
            }
            .eraseToAnyPublisher()
    }


    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?) -> AnyPublisher<T, APIError> {
        decodingTask(with: request, decodingType: T.self).tryMap { model -> T in
            guard let decodedModel = decode(model) else { throw APIError.requestFailed }
            return decodedModel
        }.mapError({ error -> APIError in
            switch (error) {
            case let apiError as APIError:
                return apiError
            default:
                return APIError.requestFailed
            }
        }).eraseToAnyPublisher()
    }

}
