//
//  RealmModel.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import Foundation
import RealmSwift

class NewsArticle: Object {

    @Persisted var source: String
    @Persisted var author: String
    @Persisted var title : String
    @Persisted var descriptionText: String
    @Persisted var url: String
    @Persisted var urlToImage: String
    @Persisted var publishedAt: String
    @Persisted var content: String
    
    convenience init (source : String, auther : String, title : String, descriptionText: String,url: String, urlToImage: String, publishedAt: String, content: String){
        self.init()
        self.author = auther
        self.source = source
        self.title = title
        self.descriptionText = descriptionText
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}


