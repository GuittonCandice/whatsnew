//
//  API.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//
import Foundation

class API: URLSessionTaskDelegate {
    let session: URLSession!
    
    init() {
    // Create a new session with APIClient as the delegate
    session = URLSession(configuration: URLSessionConfiguration.default,
    delegate: self,
    delegateQueue: nil)
    }
    
    // Perform the request
    func fetchRecords(handler: () => void) {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/api/employee/records")!)
        request.setValue(retrieveToken(), forHTTPHeaderField: "Authorization")
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    // Implement URLSessionTaskDelegate's HTTP Redirection method
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        // Create a mutable copy of the new request, add the header, call completionHandler
        var newRequest = request
        newRequest.addValue(retrieveToken(), forHTTPHeaderField: "Authorization")
        completionHandler(newRequest)
    }
}
