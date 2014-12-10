//
//  ProductView.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 09-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class ProductView: UIViewController {

    @IBOutlet var label_Title: UILabel!
    @IBOutlet var label_description: UILabel!
    @IBOutlet var imageView_productImage: UIImageView!
    @IBOutlet var button_cancel: UIButton!
    
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDel.productActive = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView_productImage.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
