//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by ChunTa Chen on 9/21/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//

import UIKit
import SwiftSpinner

class MovieDetailViewController: UIViewController
{
    @IBOutlet var titlelbl :UILabel!
    @IBOutlet var language :UILabel!
    @IBOutlet var genre :UILabel!
    @IBOutlet var duration :UILabel!
    @IBOutlet var overview :UITextView!
    
    var id:String = ""
    convenience init(mid: String)
    {
        self.init()
        id = mid
    }
    
    deinit
    {
        print("deinit MovieDetailViewController")
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
        
        let rr:Float = 1/1
        let rbutton = UIButton.init(type: .custom)
        rbutton.setImage(UIImage.init(named: "Buy"), for: UIControlState.normal)
        rbutton.addTarget(self, action: #selector(self.onBook), for: .touchDown)
        rbutton.frame = CGRect.init(x: 0, y: 0, width: 30, height: Int(30*rr))
        let rbarButton = UIBarButtonItem.init(customView: rbutton)
        self.navigationItem.rightBarButtonItem = rbarButton
        
        if (id.characters.count>0)
        {
            //--Start--
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                SwiftSpinner.show("Query Movie Detail...")
                MovieModel.queryMovieDetail(id:self.id) { [weak self] (detail:MovieDetail) in
                
                    SwiftSpinner.hide()
                    
                    self?.titlelbl.text = detail.title
                    
                    self?.genre.text = "---"
                    if (detail.genres.count>0)
                    {
                        self?.genre.text = ""
                        for genre in detail.genres
                        {
                            self?.genre.text?.append(genre.name)
                            let index:Int = detail.genres .index(of: genre)!
                            if (index<(detail.genres.count-1))
                            {
                                self?.genre.text?.append("/")
                            }
                        }
                    }
                    
                    self?.language.text = "---"
                    if (detail.original_language.characters.count>0)
                    {
                        self?.language.text = detail.original_language.uppercased()
                    }
                    
                    self?.duration.text = "---"
                    if (detail.runtime.characters.count>0)
                    {
                        self?.duration.text = String(format:"%@ min", detail.runtime)
                    }
                    
                    if (detail.overview.characters.count>0)
                    {
                        self?.overview.text = detail.overview
                    }
                }
            }
            //--End--
        }
    }
 
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func onBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func onBook()
    {
        navigationController?.pushViewController(MovieBookingViewController(), animated: true)
    }

}
