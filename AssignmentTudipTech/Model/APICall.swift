//
//  APICall.swift
//  AssignmentTudipTech
//
//  Created by Mac on 30/12/21.
//

import Foundation

class APICall {
    
    private let apiString = "https://jsonplaceholder.typicode.com/users"
    typealias success = (_ users: [User])->()
    typealias failure = (_ mssg: String)->()
    
    func getAPIData(failureClosure:@escaping failure, complisherHandler: @escaping success) {
        if let url = URL(string: apiString) {
            let session = URLSession(configuration: .default)
            let datatask = session.dataTask(with: url) { (dataFromServer, HttpUrlResponse, error) in
                if let data = dataFromServer {
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        complisherHandler(users)
                    } catch {
                        print("Error while decoding data")
                    }
                } else {
                    failureClosure("No Internet")
                }
            }
            datatask.resume()
        } else {
            print("Invalid URL")
        }
    }
}
