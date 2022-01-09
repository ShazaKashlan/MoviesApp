//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import UIKit
import Kingfisher
import ESPullToRefresh

class MovieDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewContentLabel: UILabel!
    
    @IBOutlet weak var genresScrollView: UIScrollView!
    
    
    static let identifier = "MovieDetailsViewController"
    
    private var viewModel : MovieDetailsViewModelProtocol!
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configData()
        configUI()
    }
    
    //MARK: - Public functions
    func loadMovieDetail(movieId: Int) {
        viewModel.loadMovieDetail(movieId: movieId) { [weak self] in
            self?.reloadData()
        }
    }
    
    //MARK: - Private functions
   
    private func configData() {
        viewModel = MovieDetailsViewModel(movieDetailService: MovieDetailService())
    }
    
    private func configUI() {
        self.view.backgroundColor = Constants.backgroundColor.withAlphaComponent(0.9)
        
        //labels
        movieNameLabel.textColor = .white
        releaseDateLabel.textColor = .white
        overviewLabel.textColor = .white
        overviewContentLabel.textColor = .white
        movieNameLabel.text = ""
        releaseDateLabel.text = ""
        overviewContentLabel.text = ""
        
    }

    private func reloadData() {
        //movie title
        movieNameLabel.text = viewModel.movieData.title
        
        // movie overview
        overviewContentLabel.text = viewModel.movieData.overview
        
        //release date
        configureReleaseDate(movieData: viewModel.movieData)
        
        //update image poster
        let posterImageUrlString = viewModel.movieData.posterPath
        
        let  url = URL(string: String(format: Domain.assestUrl()+posterImageUrlString!))!
        
        let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 15)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    ///
    /// Configure Release Date
    ///
    private func configureReleaseDate(movieData:MovieResponse) {
        //Release date
        let releaseDateString = movieData.releaseDate ?? ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = Constants.inputFormatter

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = Constants.outputFormatter

        guard let showDate = inputFormatter.date(from: releaseDateString) else { return }
        let movieReleaseDate = outputFormatter.string(from: showDate)
        
        //Run time value
        let movieRunTime = movieData.runtime ?? 0
        let (hour, minutes) = minutesToHours(minutes: movieRunTime)
        let runtimeString = "\(hour)h \(minutes)m"
        
        releaseDateLabel.text = movieReleaseDate + " - " + runtimeString
    }
    
    private func minutesToHours (minutes : Int) -> (Int, Int) {
      return (minutes / 60, (minutes % 60))
    }
    
    
    //MARK: - Actions
    @IBAction func closeActionClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

