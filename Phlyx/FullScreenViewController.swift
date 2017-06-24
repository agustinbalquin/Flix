//
//  FullScreenViewController.swift
//  Phlyx
//
//  Created by Agustin Balquin on 6/23/17.
//  Copyright © 2017 Agustin Balquin. All rights reserved.
//

import UIKit


class FullScreenViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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
