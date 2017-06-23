//
//  MoviesViewController.swift
//  Phlyx
//
//  Created by Agustin Balquin on 6/21/17.
//  Copyright © 2017 Agustin Balquin. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    let categories = ["Now Playing","Top Rated", "Upcoming"]
    var movies:[[String: Any]] = []
    var isMoreDataLoading = false
    var pageNum = 1
    var maxPageNum = 2
    var pageStarted = false
    var subURL = "now_playing"
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel!.text = title
        cell.overviewLabel!.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.posterView.alpha = 0.2
            UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { cell.posterView.alpha = 1.0}, completion: nil)
            cell.posterView.af_setImage(withURL: posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.posterView.image = nil
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell =  sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(subURL)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                
                let alertController = UIAlertController(title: "Cannot Get Movies", message: "Connection to server seems to be interrupted", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    self.loadMoreData()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)

                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                // TODO: Get the array of movies
                let movies = dataDictionary["results"] as! [[String: Any]]
                // TODO: Store the movies in a property to use elsewhere
                self.pageStarted = true
                self.movies = movies
                self.maxPageNum = dataDictionary["total_pages"] as! Int
                // TODO: Reload your table view data
                self.tableView.reloadData()
            }
        }
        task.resume()
        
        activityIndicator.stopAnimating()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        
        // Configure session so that completion handler is executed on main UI thread
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(subURL)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                // TODO: Get the array of movies
                let movies = dataDictionary["results"] as! [[String: Any]]
                // TODO: Store the movies in a property to use elsewhere
                self.movies = movies
                // TODO: Reload your table view data
                self.tableView.reloadData()
                
            }
            refreshControl.endRefreshing()
        }
        task.resume()
    }
    
    func incrementPageNum() {
        pageNum += 1
    }
    
    func loadMoreData() {
        if pageNum >= maxPageNum {
            return
        }
        if pageNum < maxPageNum && pageStarted {
            incrementPageNum()
        }
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(subURL)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&page=\(pageNum)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                // TODO: Get the array of movies
                let movies = dataDictionary["results"] as! [[String: Any]]
                // TODO: Store the movies in a property to use elsewhere
                for mov in movies {
                    self.movies.append(mov)
                }
                // TODO: Reload your table view data
                self.pageStarted = true
                self.isMoreDataLoading = false
                self.tableView.reloadData()
                
            }
            
            
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
    
    
    
//    
// Picker Functions
//

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch categories[row] {
        case "Now Playing": self.subURL = "now_playing"
        case "Top Rated": self.subURL = "top_rated"
        case "Upcoming": self.subURL = "upcoming"
        default: self.subURL = "now_playing"
        }
        pageNum = 1
        maxPageNum = 2
        self.pageStarted = false
        movies = []
        self.loadMoreData()
        self.tableView.reloadData()
    }
}
