//
//  ErrorType.swift
//  NewsReaderSwiftUI
//
//  Created by Tomislav Gelesic on 17.07.2021..
//

import Foundation

enum ErrorType: Error {
    case noInternet(String = "No internet")
    case general(String = "Something went wrong, please report!")
    case recoverable(String = "Ooops, something went wrong...")
}
