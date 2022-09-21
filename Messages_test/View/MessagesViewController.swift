//
//  MessagesViewController.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import UIKit

protocol MessagesViewInput: AnyObject {
    func showMeesages(messages: [String])
    func showAllert(title: String)
}

final class MessagesViewController: UIViewController {
    
    var presenter: MessagesPresenter?
    
    // Dependencies
    
    private var responseMessageCount: Int?
    private let messagesView = MessagesView()
    private let messagesDataSource = MessagesDataSource()
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Override
    
    override func loadView() {
        view = messagesView
    }
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        messagesView.tableView.delegate = self
        messagesView.tableView.dataSource = messagesDataSource
        messagesView.tableView.separatorStyle = .none
        messagesView.tableView.tableFooterView = spinner
        messagesView.tableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        messagesView.tableView.estimatedRowHeight = 100
        messagesView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
}

// MARK: - UITableViewDelegate

extension MessagesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if messagesDataSource.messages.count - 2 == indexPath.row {
            spinner.startAnimating()
            if messagesDataSource.messages.count < 80 {
            presenter?.loadMore()
            }
        }
    }
}

// MARK: - MessagesViewInput

extension MessagesViewController: MessagesViewInput {

    
    func showAllert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let retryButton = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.allertButtonPrest()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        self.spinner.stopAnimating()
        alertController.addAction(retryButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func showMeesages(messages: [String]) {
        guard responseMessageCount != 0 else {
            spinner.stopAnimating()
            return
        }

        self.responseMessageCount = messages.count
        self.spinner.stopAnimating()
        guard !messages.isEmpty else { return }
        self.messagesDataSource.messages += messages.compactMap { $0 }
        self.messagesView.tableView.reloadData()
    }
}
