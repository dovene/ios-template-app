//
//  MovieListViewController.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    private static let viewCell: String = "MovieTableViewCell"
    @IBOutlet private var moviesTableView: UITableView!
    private var viewModel : MovieListViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewItems()
        setBindings()
    }

    func setViewItems(){
        let nib = UINib(nibName: MovieListViewController.viewCell, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: MovieListViewController.viewCell)
        moviesTableView.dataSource = nil
        moviesTableView.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setMovieListViewModel(args: [Movie]){
        viewModel = MovieListViewModel(args)
    }
    
    func setBindings(){
        viewModel?.output.selectedMovie
        .subscribe(onNext: { [weak self] movie in
            self?.onMovieSelected(movie)
        }).disposed(by: disposeBag)
        
        viewModel?.output.movies
            .bind(to: moviesTableView.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)){
                 [weak self] _, movie, cell in
                    cell.setMovie(movie)
                    cell.viewModel = self?.viewModel
        }.disposed(by: disposeBag)
}
    func onMovieSelected(_ movie: Movie) {
        let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailVC.setViewModel(MovieDetailViewModel(movie))
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
}
