//
//  OfferView.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 10-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class OfferView: UIViewController {

    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_description: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button_cancel: UIButton!
    var labelDescriptionValue : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("offerview opened")
        label_description.text = labelDescriptionValue
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        println("offerview did appear")
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
//        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        appDel.startTime = NSDate()
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
