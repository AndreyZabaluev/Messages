//
//  MessagesDataSource.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import UIKit

final class MessagesDataSource: NSObject {
    
    var messages = [String]()
    
}

// MARK: - UITableViewDataSource

extension MessagesDataSource: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesCell
        cell.textLabel?.text = messages[indexPath.row]
        cell.transform = CGAffineTransform(rotationAngle: (-.pi))
        cell.textLabel!.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
}
