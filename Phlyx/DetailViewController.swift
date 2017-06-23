//
//  DetailViewController.swift
//  Phlyx
//
//  Created by Agustin Balquin on 6/21/17.
//  Copyright © 2017 Agustin Balquin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    var posterURL:URL = URL(fileURLWithPath: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie["title"] as! String
            releaseLabel.text = movie["release_date"] as! String
            overviewLabel.text = movie["overview"] as! String
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            
            if let backDropPath = movie["backdrop_path"] as? String {
                
                let backDropUrl = URL(string: baseUrl + backDropPath)
                backDropImage.af_setImage(withURL: backDropUrl!)
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                backDropImage.image = nil
            }

            
            if let posterPath = movie["poster_path"] as? String {
                
                let posterUrl = URL(string: baseUrl + posterPath)
                self.posterURL = posterUrl!
                posterView.af_setImage(withURL: posterUrl!)
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                posterView.image = nil
            }

        }

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "trailerIdentifier" {
            let largeImageViewController = segue.destination as! LargeImageViewController
            largeImageViewController.photoURL = self.posterURL
        }
        else {
            
            
            let webViewController = segue.destination as! WebViewController
            //            let photoURL:URL = URL(fileURLWithPath: "")
            //        let movURL:URL  = URL(fileURLWithPath: "https://api.themoviedb.org/3/movie/\(movie?["id"])/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
            //            let movRequest = URLRequest(url: movURL)
            //
            let urlstring = "https://api.themoviedb.org/3/movie/\((movie?["id"]!)!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
            print(urlstring)
            let url = URL(string: urlstring)!
            
            
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    
                    // TODO: Get the array of movies
                    let videos = dataDictionary["results"] as! [[String: Any]]
                    let video = videos[0]
                    let videoID = video["key"]
                    var videoURL = "https://www.youtube.com/watch?v=\(videoID!)"
                    let requestURL = URL(string: videoURL)
                    let requestQ = URLRequest(url: requestURL!)
                    webViewController.webView.loadRequest(requestQ)
                    
                }
                
                
            }
            task.resume()
            
            //            let movID = movRequest[0]
            //            let key = movID["key"]
            //            var videoURL = "https://www.youtube.com/watch?v=\(key)"
            //            let requestURL = URL(string: videoURL)
            //            let requestQ = URLRequest(url: requestURL!)
            //            webViewController.webView.loadRequest(requestQ)
            //        }
        }
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
