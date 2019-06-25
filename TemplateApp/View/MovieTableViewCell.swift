//
//  MovieTableViewCell.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import UIKit
import PINRemoteImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet private var releaseDateTextView: UILabel!
    @IBOutlet private var descriptionTextView: UILabel!
    @IBOutlet private var titleTextView: UILabel!
    @IBOutlet private var movieImageView: UIImageView!
    private var movie = Movie()
    public var viewModel : MovieListViewModel?


    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    
    private func initialize() {
        selectedBackgroundView = UIView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleItemTap))
        holderView.addGestureRecognizer(tap)
    }

    @objc func handleItemTap(){
        //movieTableViewCellDelegate?.onMovieSelected(movie)
        viewModel?.input.selectMovie.onNext(movie)
    }
  
    
    public func setMovie(_ movie: Movie) {
        self.movie = movie
        titleTextView.text = movie.title
        releaseDateTextView.text = movie.releaseDate
        descriptionTextView.text = movie.overview
        movieImageView.pin_setImage(from: URL(string: movie.getImageUrl())!)
    }

}
