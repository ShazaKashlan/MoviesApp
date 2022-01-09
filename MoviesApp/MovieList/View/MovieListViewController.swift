//
//  ViewController.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import UIKit


class MovieListViewController: UIViewController {
    
    private var viewModel : MovieListViewModelProtocol!
    
    //MARK: - Outlets
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Private Declarations
    private var spinner = UIActivityIndicatorView(style: .large)
    
    private enum MovieTableSections : Int, CaseIterable {
        case logo = 0, playing, popular
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel( trendingService: TrendingMoviesService(), movieDetailService: MovieDetailService())
        showLoader()
        setupTableView()
    }
    
    func setupTableView() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        self.moviesTableView.tableFooterView = UIView()
        viewModel.movieTrendigArray.bind { (_) in
            self.showTableView()
        }
        self.moviesTableView.es.addPullToRefresh { [self] in
            let pageNumber = viewModel.pageNumber
            viewModel.pageNumber = pageNumber + 1
            self.viewModel.fetchTrendingMovies(pageNumber: pageNumber) { [weak self] in
                self?.moviesTableView.reloadData()
            }
            
        }
        self.moviesTableView.es.startPullToRefresh()
    }
    
    func showErrorMessage(_ message: String) {
        self.showTableView()
        self.showAlert(title: "Error", message: message)
    }
    
    func showLoader() {
        self.moviesTableView.isHidden = true
        self.emptyView.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.moviesTableView.es.stopPullToRefresh()
            if self.viewModel.movieTrendigArray.value.isEmpty {
                self.showEmptyView()
            } else {
                self.moviesTableView.reloadData()
                self.moviesTableView.isHidden = false
                self.emptyView.isHidden = true
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    func showEmptyView() {
        self.moviesTableView.isHidden = true
        self.emptyView.isHidden = false
        self.activityIndicator.isHidden = true
    }
    
    ///
    //MARK: - Load Data
    ///
    private func loadData() {
        
        viewModel.fetchTrendingMovies(pageNumber: viewModel.pageNumber) { [weak self] in
            self?.moviesTableView.reloadData()
        }
        
        viewModel.movieTrendigArray.bind { (_) in
            self.moviesTableView.reloadData()
        }
    }
}

//MARK: - Tableview DataSource
extension MovieListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieTableSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trending Movies"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieTrendigArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier,
                                                           for: indexPath) as! MovieCell
        
        //configure data
        let movie = viewModel.movieTrendigArray.value[indexPath.row]
        cell.configure(movieData: movie)
        
        return cell
        
    }
}

//MARK: - TableView Delegate
extension MovieListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = Constants.backgroundHearderTableViewColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Constants.titleHearderTableViewColor
        header.textLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        //show Movie Details
        
        let movieDict = viewModel.movieTrendigArray.value[indexPath.row]
        let movieId = movieDict.id   as? Int ?? -1
        if movieId != -1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let movieDetailViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as! MovieDetailsViewController
            movieDetailViewController.modalPresentationStyle = .overCurrentContext
            self.present(movieDetailViewController, animated: true, completion: nil)
            
            movieDetailViewController.loadMovieDetail(movieId: movieId)
        }
        
    }
}
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
