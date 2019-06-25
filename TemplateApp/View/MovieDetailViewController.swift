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

class MovieDetailViewController: UIViewController {
    private var movie = Movie()
    @IBOutlet private var titleTextField: UILabel!
    @IBOutlet private var releaseDateTextField: UILabel!
    @IBOutlet private var overviewTextField: UILabel!
    @IBOutlet private var popularityTextField: UILabel!
    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var shareView: UIView!
    @IBOutlet private var topTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewItems()
    }

    func setViewItems(){
        overviewTextField.text = movie.overview
        titleTextField.text = movie.title
        topTitle.text = movie.title
        releaseDateTextField.text = movie.releaseDate
        popularityTextField.text = "Popularité: \(movie.popularity ?? 0.0)"
        movieImageView.pin_setImage(from: URL(string: movie.getImageUrl())!)
        let tap = UITapGestureRecognizer(target: self,action: #selector(share))
        shareView.addGestureRecognizer(tap)
    }

    @objc func share(){
        self.shareMessage(message: ["\(String(describing: movie.title)) ","\(String(describing: movie.overview))"], completion: { completed in
                return
        })
    }

    func setMovie(_ movie: Movie){
        self.movie = movie
    }

    func setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.makesTransparent()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
    }

}
