//
//  AllNewViewModel.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import Foundation
class AllNewsViewModel{
    
    var bindResultToViewController : (()->())={}
    
    var vMResult:News!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getAllNewsResult(apiLink :String){
        NetworkServices.fetchAllNews(apiLink: apiLink) { res in
            guard let result = res else {return}
            self.vMResult = result
            
            
        }
    }
    
}
