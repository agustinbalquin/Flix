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
