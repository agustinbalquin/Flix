//
//  LargeImageViewController.swift
//  Phlyx
//
//  Created by Agustin Balquin on 6/22/17.
//  Copyright © 2017 Agustin Balquin. All rights reserved.
//

import UIKit
import AlamofireImage

class LargeImageViewController: UIViewController {


    
    @IBOutlet weak var imageView: UIImageView!
    
    var photoURL:URL = URL(fileURLWithPath: "")
    
    
 
    @IBAction func fullscreenTap(_ sender: Any) {
        performSegue(withIdentifier: "fullSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fullScreenViewController = segue.destination as! FullScreenViewController
        fullScreenViewController.photoURL = self.photoURL
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.af_setImage(withURL: photoURL)
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fullscreenTap(_:)))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 2
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
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
