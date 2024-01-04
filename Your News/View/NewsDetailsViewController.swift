//
//  NewsDetailsViewController.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import UIKit
import SafariServices
import SDWebImage
class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var darkmode: UISwitch!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var detailsImg: UIImageView!
    var newsDescription : String?
    var newsTitle : String?
    var newsImg : String = " " 
    var newsContent : String?
    var web : String?
    var autor : String?
    var publicationDate : String?
    let appDelegate = UIApplication.shared.windows.first
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = newsDescription
        titleLabel.text = newsTitle
        contentLabel.text = newsContent
        author.text = autor
        date.text = publicationDate
      
        
        if let url = URL(string: newsImg) {
            detailsImg.sd_setImage(with: url)
        } else {
            detailsImg.image = UIImage(named: "news")
        }
        
        
        if UserDefaults.standard.bool(forKey: "Dark"){
            darkmode.isOn = true
            appDelegate?.overrideUserInterfaceStyle = .dark
            modeLabel.text = "dark"

        }
        else{
            darkmode.isOn = false
            appDelegate?.overrideUserInterfaceStyle = .light
            modeLabel.text = "light"

        }
    }
    
    func openWebview(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    

    @IBAction func webButton(_ sender: Any) {
        let url = URL(string: web ?? "")!
        if Utilites.isConnectedToNetwork() == false{
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your connection and try again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            present(alert, animated: true)
        }else{
            openWebview(url: url)
        }
        
    }
    
    @IBAction func darkModeButton(_ sender: UISwitch) {
        
        if #available(iOS 13, *){
            if sender.isOn{
                UserDefaults.standard.set(true, forKey: "Dark")
                appDelegate?.overrideUserInterfaceStyle = .dark
               
                return
            }
            else{
                UserDefaults.standard.set(false, forKey: "Dark")
                appDelegate?.overrideUserInterfaceStyle = .light
               
            }
            
        }else{
            print("DarkMode is unAvailable")
        }
    }
    
}
