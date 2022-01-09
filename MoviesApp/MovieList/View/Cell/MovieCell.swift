//
//  MovieCell.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import UIKit
import Kingfisher


class MovieCell : UITableViewCell{
    
    // MARK: - IBOutlets
    @IBOutlet weak var poster: UIImageView!
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    
    //MARK: - Public functions
    func configure(movieData: Movie) {
        self.backgroundColor = .clear
        
        //Update Data
        title.text = movieData.title as? String ?? ""
        releaseDate.text = ""// release date config at configureReleaseDate
        
        //update Image
        let  url = URL(string: String(format: Domain.assestUrl()+(movieData.posterPath)! ))
        
        let processor = DownsamplingImageProcessor(size: poster.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        poster.kf.indicatorType = .activity
        poster.kf.setImage(
            
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        self.configureReleaseDate(movie: movieData)
        
    }
 
    //MARK: - Private functions
    private func configureReleaseDate(movie: Movie) {
        //Release Date value
        let releaseDateString = movie.releaseDate as? String ?? ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = Constants.inputFormatter
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = Constants.outputFormatter
        
        guard let showDate = inputFormatter.date(from: releaseDateString) else { return }
        let movieReleaseDate = outputFormatter.string(from: showDate)
        
        releaseDate.text = movieReleaseDate
    }
    
    private func minutesToHours (minutes : Int) -> (Int, Int) {
        return (minutes / 60, (minutes % 60))
    }
    
}
