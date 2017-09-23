//
//  ViewController.swift
//  MovieSearch
//
//  Created by ChunTa Chen on 9/19/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//

import UIKit
import UILoadControl
import GearRefreshControl
import SDWebImage

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView :UITableView!
    var movieNailList:[MovieNail] = []
    var pageToload:Int = 0
    var backdrop_pickindex:Int = 0
    var backdrop_placeholder:[String] = ["BackdropPlaceHolder_Blue",
                                         "BackdropPlaceHolder_LitGrass",
                                         "BackdropPlaceHolder_LitPink"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //LeftBarItem as Title
        let font:UIFont = UIFont.init(name: "HelveticaNeue-UltraLight", size: 23)!
        let attributes:[String : Any] = [NSFontAttributeName: font, NSForegroundColorAttributeName:UIColor.darkGray];
        let customItem:UIBarButtonItem = UIBarButtonItem(title: "tmDB", style: .plain, target: nil, action: nil)
        customItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
        navigationItem.leftBarButtonItem = customItem
        
        //Register TableCell
        tableView.register(UINib(nibName: "MovieNailCell", bundle: nil), forCellReuseIdentifier: "MovieNaillCell")
        
        //Refresh Control
        tableView.refreshControl = GearRefreshControl(frame: self.view.bounds)
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPage), for: UIControlEvents.valueChanged)
        
        //LoadMore Control
        tableView.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
        tableView.loadControl?.heightLimit = 100.0

        //Load page at startup
        loadPage()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 92
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movieNailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieNaillCell", for: indexPath) as! MovieNailCell
        
        //Title image
        let imgurl:String = String(format:"http://image.tmdb.org/t/p/w185/%@", movieNailList[indexPath.row].poster_path)
        cell.posterImgView.sd_setImage(with: URL(string: imgurl), placeholderImage: UIImage(named: "ImagePlaceHolder"))
        cell.posterImgView.layer.borderWidth = 2
        
        //Background image
        let bgimgurl:String = String(format:"http://image.tmdb.org/t/p/w500/%@", movieNailList[indexPath.row].backdrop_path)
        let rindex:Int = indexPath.row % backdrop_placeholder.count
        let placeholderimgname = backdrop_placeholder[rindex]
        cell.backgropImgView.sd_setImage(with: URL(string: bgimgurl), placeholderImage: UIImage(named: placeholderimgname))
        
        //Title text
        cell.titleTxt.text = movieNailList[indexPath.row].title
        
        //Populariy text
        cell.popularityTxt.text = movieNailList[indexPath.row].popularity
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        navigationController?.pushViewController(MovieDetailViewController(mid: movieNailList[indexPath.row].id), animated: true)
    }
    
    //MARK: - Scroll View update loadControl when user scrolls de tableView
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        scrollView.loadControl?.update()
        (scrollView.refreshControl as! GearRefreshControl).scrollViewDidScroll(scrollView)
    }

    
    //MARK - load more tableView data
    func loadMore(sender: AnyObject?)
    {
        print("load more")
        loadPage()
    }
    
    //MARK - refresh/load page
    func refreshPage()
    {
        print("refresh....")
        pageToload = 1
        MovieModel.queryPage(page: pageToload) { [unowned self] (results:Array<MovieNail>) in
            self.movieNailList = []
            for movienail in results
            {
                self.movieNailList.append(movienail)
            }
            self.tableView.reloadData()
            (self.tableView.refreshControl as! GearRefreshControl).endRefreshing()
            
            self.displayPage()
        }
    }
    
    func loadPage()
    {
        pageToload += 1
        
        MovieModel.queryPage(page: pageToload) { [unowned self] (results:Array<MovieNail>) in
            for movienail in results
            {
                self.movieNailList.append(movienail)
            }
            self.tableView.reloadData()
            self.tableView.loadControl?.endLoading()
            
            self.displayPage()
        }
    }
    
    func displayPage()
    {
        if (navigationItem.rightBarButtonItem==nil)
        {
            let font:UIFont = UIFont.init(name: "HelveticaNeue-UltraLight", size: 23)!
            let attributes:[String : Any] = [NSFontAttributeName: font, NSForegroundColorAttributeName:UIColor.darkGray];
            let customItem:UIBarButtonItem = UIBarButtonItem(title: String(format:"%d", pageToload), style: .plain, target: nil, action: nil)
            customItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
            navigationItem.rightBarButtonItem = customItem
        }
        else
        {
            navigationItem.rightBarButtonItem?.title = String(format:"%d", pageToload)
        }
    }
    
}

