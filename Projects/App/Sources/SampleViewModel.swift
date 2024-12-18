//
//  SampleViewModel.swift
//  DevWiki
//
//  Created by yuraMacBookPro on 12/16/24.
//

import Foundation
import Combine
import Core

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
