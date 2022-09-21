//
//  MessagesPresenter.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import UIKit

final class MessagesPresenter {
    
    weak var view: MessagesViewInput?
    private let messagesService: MessagesService
    private let spinner = UIActivityIndicatorView(style: .medium)
    private var counter = 0
    private var isLoading = false
    
    // MARK: - Initialization
    
    init(messagesService: MessagesService) {
        self.messagesService = messagesService
    }
    
    func viewDidLoad() {
        getMessages(page: counter)
    }
    
    func allertButtonPrest() {
        let maintCouner = counter * 20
        getMessages(page: maintCouner)
    }
    
    func loadMore() {
        let maintCouner = counter * 20
        getMessages(page: maintCouner)
    }
    
    // MARK: - Private
    
    private func getMessages(page: Int) {
        guard !isLoading else { return }
        let counter = String(page)
        isLoading = true
        messagesService.loadMessages(counter: counter) { [ weak self ] result in
            switch result {
            case .success(let message):
                DispatchQueue.main.async {
                    if message.isEmpty {
                        self?.view?.showAllert(title: "the message didn't arrive")
                        return
                    }
                    self?.view?.showMeesages(messages: message)
                    self?.counter += 1
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showAllert(title: error.localizedDescription)
                }
            }
            self?.isLoading = false
        }
    }
}
