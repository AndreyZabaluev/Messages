//
//  NetworkService.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import Foundation

protocol MessagesService {
    func loadMessages(counter: String, completion: @escaping MessagesCompletion)
}

final class MessagesServiceImpl: MessagesService {
    func loadMessages(counter: String, completion: @escaping MessagesCompletion) {
        getRequest(URLString: baseMessagesURL + counter) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try? JSONDecoder().decode(MessagesResponse.self, from: data)
                    completion(.success(jsonData?.result ?? []))
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func getRequest(URLString: String, completion: @escaping ResultCompletion) {
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
}
