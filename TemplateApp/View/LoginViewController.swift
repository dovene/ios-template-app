//
//  ViewController.swift
//  TemplateApp
//
//  Created by Dov on 22/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import UIKit
import SwiftyBeaver
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    private  var viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewItems()
        setBindings()
    }
    
    func setViewItems() {
        //UI
        self.navigationController?.isNavigationBarHidden = true
        emailTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
    }
    
    func setBindings(){
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.input.mailInput)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.input.passwordInput)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.input.loginClick)
            .disposed(by: disposeBag)
        
        viewModel.output.dataInputError
            .subscribe(onNext: { [weak self] in
                self?.presentAlertMessage()
            }) .disposed(by: disposeBag)

        viewModel.output.serviceError
            .subscribe(onNext: { [weak self] res in
                self?.presentAlertMessage(res)
            }) .disposed(by: disposeBag)
        
        viewModel.output.movies
            .subscribe(onNext: { [weak self] movies in
                self?.launchMovieList(movies)
            }) .disposed(by: disposeBag)
    }
    
    func launchMovieList(_ movies: [Movie]){
            let moviesVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
            moviesVC.setMovieListViewModel(args: movies)
            self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    func presentAlertMessage(_ message: String = ""){
        let alert = UIAlertController(title: "Attention !", message: "All information are mandatory ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

