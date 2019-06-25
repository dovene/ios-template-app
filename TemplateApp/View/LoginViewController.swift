//
//  ViewController.swift
//  TemplateApp
//
//  Created by Dov on 22/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import UIKit
import SwiftyBeaver

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViewItems()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setViewItems() {
        //UI
        emailTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
        
        //Events
        loginButton.addTarget(self, action: #selector(onLoginClicked), for: .touchUpInside)
    }

    @objc func onLoginClicked(){
        
        if(emailTextField.text?.isEmpty ?? true) && (passwordTextField.text?.isEmpty ?? true)  {
            presentAlertMessage()
        } else {
            lauchMovieList()
        }
    }
    
    func lauchMovieList(){
        MovieRepository().getMovies(){[weak self] movies in
            SwiftyBeaver.self.info("movies \(movies)")
            let moviesVC = self?.storyboard?.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
            moviesVC.setMovies(args: movies)
            self?.navigationController?.pushViewController(moviesVC, animated: true)
        }
    }
    
    func presentAlertMessage(){
        let alert = UIAlertController(title: "Attention !", message: "All information are mandatory ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

