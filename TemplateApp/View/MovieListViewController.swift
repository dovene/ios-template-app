//
//  MovieListViewController.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    private static let viewCell: String = "MovieTableViewCell"
    @IBOutlet private var moviesTableView: UITableView!
    private var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func setViewItems(){
        let nib = UINib(nibName: MovieListViewController.viewCell, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: MovieListViewController.viewCell)
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }

    func setMovies(args: [Movie]){
    self.movies = args
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate, movieTableViewCellDelegate {

    func onMovieSelected(_ movie: Movie) {
        let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailVC.setMovie(movie)
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListViewController.viewCell) as! MovieTableViewCell
        cell.movieTableViewCellDelegate = self
        cell.setMovie(movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 345
    }
}
