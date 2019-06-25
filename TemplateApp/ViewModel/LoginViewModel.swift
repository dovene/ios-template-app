//
//  LoginViewModel.swift
//  TemplateApp
//
//  Created by Dov on 25/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel : BaseViewModel {

    // MARK: - Inputs
    struct Input {
        let mailInput: AnyObserver<String>
        let passwordInput: AnyObserver<String>
        let loginClick: AnyObserver<Void>
    }

    
    // MARK: - Outputs
    struct Output {
        let movies: Observable<[Movie]>
        let loginClicked: Observable<Void>
        let dataInputError: Observable<Void>
        let serviceError: Observable<String>
    }
  
    let input: Input
    let output: Output
    
    private let mailInputSubject = PublishSubject<String>()
    private let passwordInputSubject = PublishSubject<String>()
    private let loginClickSubject = PublishSubject<Void>()
    private let dataInputErrorSubject = PublishSubject<Void>()
    private let serviceErrorSubject = PublishSubject<String>()
    private let moviesSubject = ReplaySubject<[Movie]>.create(bufferSize: 1)

    
    override init() {
        input = Input(mailInput: mailInputSubject.asObserver(), passwordInput: passwordInputSubject.asObserver(), loginClick: loginClickSubject.asObserver())
        output = Output(movies: moviesSubject.asObservable(), loginClicked: loginClickSubject.asObservable(), dataInputError: dataInputErrorSubject.asObservable(), serviceError:  serviceErrorSubject.asObservable())
        
        super.init()
        let inputCombination = Observable.combineLatest(mailInputSubject.asObservable(), passwordInputSubject.asObservable()){($0,$1)}
       
        output.loginClicked
            .withLatestFrom(inputCombination){($0, $1)}
            .subscribe(onNext: { [weak self] res in
                let (mail, pass) = res.1
                if(mail.isEmpty) || (pass.isEmpty)  {
                    self?.onDataInputError()
                }else {
                    self?.callMoviesService()
                }
            }).disposed(by: disposeBag)
    
    }
    
    private func onDataInputError(){
        self.dataInputErrorSubject.onNext(())
    }
    
    private func callMoviesService(){
        MovieRepository().getMovies(){[weak self] movies, error in
            if let movies = movies {
                self?.moviesSubject.onNext(movies)
            } else {
                self?.serviceErrorSubject.onNext(error?.description ?? "")
            }
        }
    }
    
}
