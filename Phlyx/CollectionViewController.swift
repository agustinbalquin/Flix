//
//  CollectionViewController.swift
//  Phlyx
//
//  Created by Agustin Balquin on 6/22/17.
//  Copyright © 2017 Agustin Balquin. All rights reserved.
//

import UIKit
import AlamofireImage

class CollectionViewController: UIViewController, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies:[[String: Any]] = []
    var pageNum = 1
    var maxPageNum = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
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
                self.collectionView.reloadData()
                
            }
            
            
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.codepath.auggie", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.item]
        
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            
            cell.movieImage.af_setImage(withURL: posterUrl!)
            
            
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.movieImage.image = nil
            
        }
        
        return cell
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func incrementPageNum() {
        pageNum += 1
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
