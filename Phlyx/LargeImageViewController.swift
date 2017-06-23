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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.af_setImage(withURL: photoURL)
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
