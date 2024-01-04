//
//  ViewController.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import UIKit
import RealmSwift
import SDWebImage
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
   
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var allNewsViewModel:AllNewsViewModel?
    @IBOutlet weak var newsTableView: UITableView!
    var allNewsArr:News?
    var newsArray : [NewsArticle]?
    
    let appDelegate = UIApplication.shared.windows.first
   

    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "Dark"){
            
            appDelegate?.overrideUserInterfaceStyle = .dark

        }
        else{
           
            appDelegate?.overrideUserInterfaceStyle = .light

        }
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        
        allNewsViewModel = AllNewsViewModel()
        if Utilites.isConnectedToNetwork() == false{
            Utilites.displayToast(message: "you are offline", seconds: 5, controller: self)
           
            self.newsArray = DataBaseHelper.shared.getAllArticles()
            self.newsTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }else{
            
        allNewsViewModel?.getAllNewsResult(apiLink:URLServiceConstant.baseUrl)
        
            allNewsViewModel?.bindResultToViewController = {() in
                DispatchQueue.main.async {
                    self.newsArray = []
                    self.allNewsArr = self.allNewsViewModel?.vMResult
                    self.allNewsArr?.articles?.forEach({
                        article in
                        let news = NewsArticle(source: article.source?.name ?? "", auther: article.author ?? "", title: article.title  ?? "", descriptionText: article.description ?? "", url: article.url  ?? "", urlToImage: article.urlToImage  ?? "", publishedAt: article.publishedAt  ?? "", content: article.content  ?? "")
                        
                        self.newsArray?.append(news)
                        
                        DataBaseHelper.shared.saveArtricle(newArticle: news)
                     
                    })
                    self.newsTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    
                }
            }
            

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
        
   
    }
    @objc private func refreshData(_ sender: Any) {
        allNewsViewModel?.getAllNewsResult(apiLink:URLServiceConstant.baseUrl)
        
            allNewsViewModel?.bindResultToViewController = {() in
                DispatchQueue.main.async {
                    self.allNewsArr = self.allNewsViewModel?.vMResult
                    self.newsTableView.refreshControl?.endRefreshing()
                    self.newsTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Utilites.isConnectedToNetwork() == false{
            return newsArray?.count ?? 0
        }
        return allNewsArr?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! HomeNewsTableViewCell
        if Utilites.isConnectedToNetwork() == false{
            cell.HomeNewsTitle.text = newsArray?[indexPath.row].title
            cell.publicationDate.text = newsArray?[indexPath.row].publishedAt
            cell.newsDescription.text = newsArray?[indexPath.row].descriptionText
            cell.newsSource.text = newsArray?[indexPath.row].source
            cell.HomeNewsImage.image = UIImage(named:newsArray?[indexPath.row].urlToImage ?? "")
        }else
        {
            cell.HomeNewsTitle.text = allNewsArr?.articles?[indexPath.row].title
            cell.publicationDate.text = allNewsArr?.articles?[indexPath.row].publishedAt
            cell.newsDescription.text = allNewsArr?.articles?[indexPath.row].description
            cell.newsSource.text = allNewsArr?.articles?[indexPath.row].source?.name
            cell.HomeNewsImage.sd_setImage(with: URL(string: allNewsArr?.articles?[indexPath.row].urlToImage ?? ""))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let newsDetails = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetailsViewController
        if Utilites.isConnectedToNetwork() == false{
            
            newsDetails.newsDescription = newsArray?[indexPath.row].descriptionText
            newsDetails.web = newsArray?[indexPath.row].url
            newsDetails.newsTitle = newsArray?[indexPath.row].title
            newsDetails.newsImg = newsArray?[indexPath.row].urlToImage ??  ""
            newsDetails.newsContent = newsArray?[indexPath.row].content
            newsDetails.autor = newsArray?[indexPath.row].author
            newsDetails.publicationDate = newsArray?[indexPath.row].publishedAt
            
        }
        else{
          
            
            newsDetails.newsDescription = allNewsArr?.articles?[indexPath.row].description
            newsDetails.web = allNewsArr?.articles?[indexPath.row].url
            newsDetails.newsTitle = allNewsArr?.articles?[indexPath.row].title
            newsDetails.newsImg = allNewsArr?.articles?[indexPath.row].urlToImage ?? ""
            newsDetails.newsContent = allNewsArr?.articles?[indexPath.row].content
            newsDetails.autor = allNewsArr?.articles?[indexPath.row].author
            newsDetails.publicationDate = allNewsArr?.articles?[indexPath.row].publishedAt
            
        }
        self.navigationController?.pushViewController(newsDetails, animated: true)
    }
    
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.bounds.height / 2
    }
}

