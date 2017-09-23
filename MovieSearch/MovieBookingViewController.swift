//
//  MovieBookingViewController.swift
//  MovieSearch
//
//  Created by ChunTa Chen on 9/23/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner

class MovieBookingViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet var webview:UIWebView!
    
    deinit
    {
        print("Release MovieBookingViewController")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //LeftItemButton
        let lr:Float = 17/21
        let lbutton = UIButton.init(type: .custom)
        lbutton.setImage(UIImage.init(named: "Back"), for: UIControlState.normal)
        lbutton.addTarget(self, action: #selector(self.onBack), for: .touchDown)
        lbutton.frame = CGRect.init(x: 0, y: 0, width: 30, height: Int(30*lr))
        let lbarButton = UIBarButtonItem.init(customView: lbutton)
        self.navigationItem.leftBarButtonItem = lbarButton
        
        //Load Website
        SwiftSpinner.show("Loading Booking Website...")
        webview.delegate = self
        let therequest:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: "http://www.cathaycineplexes.com.sg/")!,
                                                                 cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        webview .loadRequest(therequest as URLRequest)
        
    }
    
    func onBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        SwiftSpinner.hide()
    }
    
}
