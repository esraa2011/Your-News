//
//  DataBaseHelper.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import Foundation
import RealmSwift

class DataBaseHelper{
    static let shared = DataBaseHelper()
    
    private var realm = try! Realm()
    
    func saveArtricle(newArticle :NewsArticle){
        try! realm.write{
            realm.add(newArticle)
        }
    }
    
    func getDatabaseURL() -> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func getAllArticles()  -> [NewsArticle]{
        return Array(realm.objects(NewsArticle.self))
    }
    
    func deleteArtricle(newArticle :NewsArticle){
        try! realm.write{
            realm.delete(newArticle)
        }
    }
}
