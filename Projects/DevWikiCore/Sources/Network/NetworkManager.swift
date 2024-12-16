//
//  NetworkManager.swift
//  DevWikiCore
//
//  Created by yuraMacBookPro on 12/16/24.
//

import Foundation
import Combine

// MARK: - Error Type
public enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
}

// MARK: - Http Method
public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - EndPoint
public enum Endpoint {
    case examplePostOne
    case examplePutOne
    case exampleDelete
    case examplePostTwo
    case exampleGet
    case examplePutTwo
    
    var path: String {
        switch self {
        case .examplePostOne:
            return "/api/postOne"
        case .examplePutOne:
            return "/api/putOne"
        case .exampleDelete:
            return "/api/delete"
        case .examplePostTwo:
            return "/api/postTwo"
        case .exampleGet:
            return "/api/get"
        case .examplePutTwo:
            return "/api/puTwo"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .exampleGet:
            return .get
        case .examplePostOne, .examplePostTwo:
            return .post
        case .examplePutOne, .examplePutTwo:
            return .put
        case .exampleDelete:
            return .delete
        }
    }
}

// MARK: - Base URL
public enum APIEnvironment {
    case development
    case staging
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            return "development.example.com"
        case .staging:
            return "staging.example.com"
        case .production:
            return "production.example.com"
        }
    }
}

public protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint, headers: [String: String]?, parameters: Encodable?) -> AnyPublisher<T, APIError>
}



public class NetworkManager: NetworkService {
    private let baseURL: String
    
    public init(environment: APIEnvironment = NetworkManager.defaultEnvironment()) {
        self.baseURL = environment.baseURL
    }
    
    public static func defaultEnvironment() -> APIEnvironment {
#if DEBUG
        return .development
#elseif STAGING
        return .staging
#else
        return .production
#endif
    }
    
    // MARK: - Header
    private func defaultHeaders() -> [String: String] {
        var headers: [String: String] = [
            "Platform": "iOS",
            "User-Token": "your_user_token",
            "uid": "user-id"
        ]
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers["App-Version"] = appVersion
        }
        
        return headers
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, headers: [String: String]? = nil, parameters: Encodable? = nil) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: baseURL + endpoint.path) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        let allHeaders = defaultHeaders().merging(headers ?? [:], uniquingKeysWith: { (_, new) in new })
        for (key, value) in allHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let parameters = parameters {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonData = try JSONEncoder().encode(parameters)
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: APIError.requestFailed("Encoding parameters failed.")).eraseToAnyPublisher()
            }
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse,
                   (200..<300).contains(httpResponse.statusCode) {
                    return data
                } else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    throw APIError.requestFailed("Request failed with status code: \(statusCode)")
                }
            }
            .decode(type: ResponseWrapper<T>.self, decoder: JSONDecoder())
            .tryMap { (responseWrapper) -> T in
                guard let status = responseWrapper.status else {
                    throw APIError.requestFailed("Missing status.")
                }
                switch status {
                case 200:
                    guard let data = responseWrapper.data else {
                        throw APIError.requestFailed("Missing data.")
                    }
                    return data
                default:
                    let message = responseWrapper.message ?? "An error occurred."
                    throw APIError.requestFailed(message)
                }
            }
            .mapError { error -> APIError in
                if error is DecodingError {
                    return APIError.decodingFailed
                } else if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.requestFailed("An unknown error occurred.")
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Sample Model
struct ResponseModel: Codable {
  var id: Int
  var name: String
  var email: String
  var age: Int
  var city: String
}

// MARK: - Sample ViewModel
class ResponseViewModel: ObservableObject {

    private let networkService: NetworkService
    private var cancellables: Set<AnyCancellable> = []

    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }

    func signUp(onCompletion: @escaping (Bool) -> ())  {
        let response: AnyPublisher<ResponseModel, APIError> = networkService.request(.exampleGet, headers: nil, parameters: nil)
        response
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                        onCompletion(false)
                }
            }
            receiveValue: { response in
                print(response)

                onCompletion(true)
            }
            .store(in: &cancellables)
    }
}
