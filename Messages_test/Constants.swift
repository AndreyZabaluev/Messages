//
//  Constants.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import Foundation

typealias ResultCompletion = (Result<Data, Error>) -> ()
typealias MessagesCompletion = (Result<[String], Error>) -> ()
typealias ErrorCompletion = (Error) -> ()

let baseMessagesURL = "https://numia.ru/api/getMessages?offset="
