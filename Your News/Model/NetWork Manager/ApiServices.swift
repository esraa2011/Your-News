//
//  ApiServices.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import Foundation

protocol NetworkServicesProtocol {
    static func fetchAllNews(apiLink : String,compilitionHandler : @escaping (News?)-> Void)
    
}

class NetworkServices : NetworkServicesProtocol{
    static func fetchAllNews(apiLink: String, compilitionHandler: @escaping (News?) -> Void) {
        
        let url = URL(string: "\(apiLink)")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
               // print(" data\(String(describing: data))")
                let result = try JSONDecoder().decode(News.self, from: data ?? Data())
                compilitionHandler(result)
               // print("result \(result)")
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
        
    }
    
    
}
