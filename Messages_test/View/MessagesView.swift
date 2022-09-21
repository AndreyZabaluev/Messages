//
//  MessagesView.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import UIKit

final class MessagesView: UIView {
    
    let tableView = UITableView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configureUI() {
        addSubview(tableView)
        tableView.register(MessagesCell.self, forCellReuseIdentifier: "MessageCell")
        backgroundColor = .white
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
