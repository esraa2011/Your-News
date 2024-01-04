//
//  MokeNetWorkClass.swift
//  Your NewsTests
//
//  Created by Esraa AbdElfatah on 02/08/2023.
//

import Foundation
import Your_News

class MokeNetworkManager{
    
    static var newsData = Constant.newsData.allNewsData.rawValue
    
   
}
extension MokeNetworkManager :NetworkServicesProtocol{
    
    static func fetchALLNews(apiLink: String, compilitionHandler: @escaping (news?) -> Void) {
        let data = Data(newsData.utf8)
        do {
            let result = try JSONDecoder().decode(news.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
}
