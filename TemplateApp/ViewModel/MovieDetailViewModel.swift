//
//  MovieDetailViewModel.swift
//  TemplateApp
//
//  Created by Dov on 25/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import RxSwift


class MovieDetailViewModel: BaseViewModel {
    
    // MARK: - Inputs
    struct Input {
        let clickShare: AnyObserver<Void>
    }
    // MARK: - Outputs
    struct Output {
        let shareClicked: Observable<Movie>
        let title: Observable<String>
        let releaseDate: Observable<String>
        let overview: Observable<String>
        let popularity: Observable<String>
        let movieImage: Observable<String>
    }
    
    let input: Input
    let output: Output
    
    private let titleSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let releaseDateSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let overviewSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let movieImageSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let popularitySubject = ReplaySubject<String>.create(bufferSize: 1)
    private let shareClickSubject = PublishSubject<Void>()
    private let shareClickedSubject = PublishSubject<Movie>()
    
    
     init(_ movie: Movie) {
        input = Input( clickShare: shareClickSubject.asObserver())
        output = Output(shareClicked: shareClickedSubject.asObservable(),title: titleSubject.asObservable(), releaseDate: releaseDateSubject.asObservable(), overview: overviewSubject.asObservable(), popularity: popularitySubject.asObservable(), movieImage: movieImageSubject.asObservable())

        super.init()

        titleSubject.onNext(movie.title ?? "")
        releaseDateSubject.onNext(movie.releaseDate ?? "")
        overviewSubject.onNext(movie.overview ?? "")
        popularitySubject.onNext("Popularité: \(movie.popularity ?? 0.0)")
        movieImageSubject.onNext(movie.getImageUrl())
        shareClickSubject.asObservable()
            .subscribe(onNext: {[weak self] in
                self?.shareClickedSubject.onNext(movie)
            }).disposed(by: disposeBag)
    }
    
}


