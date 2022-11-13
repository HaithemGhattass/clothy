//
//  userviewmodel.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 11/11/2022.
//

import Foundation
final class UsersViewModel : ObservableObject{
    @Published var hasError = false
        @Published var error: UserError?
        
    @Published var users = [User] ()
    
        @Published private(set) var isRefreshing = false
    
    func fetchuser(){
        let userstringurl = "http://192.168.1.5:9090/api/us"
        if let url = URL(string:userstringurl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                                
                                    
                                    DispatchQueue.main.async {
                                        
                                        defer {
                                            self?.isRefreshing = false
                                        }
                                        
                                        if let error = error {
                                            self?.hasError = true
                                            self?.error = UserError.custom(error: error)
                                        } else {
                                            
                                            let decoder = JSONDecoder()
                                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                                            
                                            if let data = data,
                                               let users = try? decoder.decode([User].self, from: data) {
                                                self?.users = users
                                            } else {
                                                self?.hasError = true
                                                self?.error = UserError.failedToDecode
                                            }
                                        }
                                    }
                }.resume()
        }
        
    }
}
extension UsersViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
