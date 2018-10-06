//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Raeleen Watson on 9/13/18.
//  Copyright © 2018 Raeleen Watson. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: . valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        
        fetchMovies()
        
    }
    
    func fetchMovies() {
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            self.activityIndicator.stopAnimating()
        }

        
//        MovieApiManager().popularMovies{ (movies: [Movie]?, error: Error?) in
//            if let movies = movies {
//                self.movies = movies
//                self.tableView.reloadData()
//                self.refreshControl.endRefreshing()
//
//            }
//            self.activityIndicator.stopAnimating()
//
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
