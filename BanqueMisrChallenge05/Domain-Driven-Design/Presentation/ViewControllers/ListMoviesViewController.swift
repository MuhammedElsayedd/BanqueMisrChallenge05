//
//  ListMoviesViewController.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

enum MovieCategory: String {
    case nowPlaying
    case popular
    case upcoming
}

class ListMoviesViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var category: MovieCategory = .nowPlaying {
        didSet {
            viewModel?.category = category
        }
    }
    private var viewModel: ListMoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        let networkManager = NetworkManager.shared
        let movieRepository = MovieRepositoryImpl(networkManager: networkManager)
        
        viewModel = ListMoviesViewModel(movieRepository: movieRepository)
    }
    
    private func setupBindings() {
        viewModel.category = category
        

        viewModel.onMoviesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error)
            }
        }
    }
    
    func fetchMovies() {
        viewModel?.fetchMovies()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        if let movie = viewModel?.movies[indexPath.row] {
            cell.configure(with: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let movie = viewModel?.movies[indexPath.row] {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                   vc.movieId = movie.id
                   self.navigationController?.pushViewController(vc, animated: true)
               }
           }
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
