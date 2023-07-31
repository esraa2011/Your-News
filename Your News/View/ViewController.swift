//
//  ViewController.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var allNewsViewModel:AllNewsViewModel?
    @IBOutlet weak var newsTableView: UITableView!
    var allNewsArr:News?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        allNewsViewModel = AllNewsViewModel()
        
        
        allNewsViewModel?.getAllNewsResult(apiLink:URLServiceConstant.baseUrl)
        
        allNewsViewModel?.bindResultToViewController = {() in
            DispatchQueue.main.async {
                
                self.allNewsArr = self.allNewsViewModel?.vMResult
                self.newsTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNewsArr?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! HomeNewsTableViewCell
        cell.HomeNewsTitle.text = allNewsArr?.articles?[indexPath.row].title
        return cell
    }
    


}

