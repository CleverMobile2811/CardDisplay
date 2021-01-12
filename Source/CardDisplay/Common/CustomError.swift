//
//  CustomError.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

enum CustomError: String, Error {

    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."

}
