//
//  SplashScreenViewController.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 01/08/2023.
//

import UIKit
import Lottie
class SplashScreenViewController: UIViewController {

    private let animationView = animationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
               let vc = self.storyboard?.instantiateViewController(identifier: "TabBar") as! UITabBarController
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
    }
    
    private func setupAnimations(){
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: 400)
        animationView.center = view.center
        view.addSubview(animationView)
        animationView.animation = Animation.named("news")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
  
}
