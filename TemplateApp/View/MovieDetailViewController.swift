//
//  MovieDetailViewController.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
    @IBOutlet private var titleTextField: UILabel!
    @IBOutlet private var releaseDateTextField: UILabel!
    @IBOutlet private var overviewTextField: UILabel!
    @IBOutlet private var popularityTextField: UILabel!
    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var shareView: UIView!
    @IBOutlet private var topTitle: UILabel!
    private var viewModel : MovieDetailViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewItems()
        setBindings()
    }

    func setViewItems(){
        let tap = UITapGestureRecognizer(target: self,action: #selector(shareClicked))
        shareView.addGestureRecognizer(tap)
    }
    
    func setBindings(){
        viewModel?.output.title
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel?.output.title
            .bind(to: topTitle.rx.text)
            .disposed(by: disposeBag)
        viewModel?.output.overview
            .bind(to: overviewTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel?.output.releaseDate
            .bind(to: releaseDateTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel?.output.popularity
            .bind(to: popularityTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel?.output.movieImage
            .subscribe(onNext:{ [weak self] url in
                self?.movieImageView.pin_setImage(from: URL(string: url))
            })
            .disposed(by: disposeBag)
        viewModel?.output.shareClicked
            .subscribe(onNext:{ [weak self] movie in
                self?.shareMovie(movie)
            })
            .disposed(by: disposeBag)
    }

    @objc func shareClicked(){
        viewModel?.input.clickShare.onNext(())
    }

    func shareMovie(_ movie: Movie){
        self.shareMessage(message: ["\(String(describing: movie.title)) ","\(String(describing: movie.overview))"], completion: { completed in
            return
        })
    }

    func setViewModel(_ viewModel: MovieDetailViewModel){
        self.viewModel = viewModel
    }

    func setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.makesTransparent()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
    }

}
