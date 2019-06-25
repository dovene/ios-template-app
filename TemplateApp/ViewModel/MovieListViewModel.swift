//
//  MovieListViewModel.swift
//  TemplateApp
//
//  Created by Dov on 25/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import RxSwift

class MovieListViewModel: BaseViewModel {
    
    // MARK: - Inputs
    struct Input {
        let selectMovie: AnyObserver<Movie>
    }
    // MARK: - Outputs
    struct Output {
        let selectedMovie: Observable<Movie>
        let movies: Observable<[Movie]>
    }
    
    let input: Input
    let output: Output
    
    private let movieSelectionSubject = PublishSubject<Movie>()
    private let moviesSubject = ReplaySubject<[Movie]>.create(bufferSize: 1)

     init(_ movies: [Movie]) {
        input = Input(selectMovie: movieSelectionSubject.asObserver())
        output = Output(selectedMovie: movieSelectionSubject.asObservable(), movies: moviesSubject.asObservable())
        
        super.init()
        moviesSubject.onNext(movies)
    }
    
}

