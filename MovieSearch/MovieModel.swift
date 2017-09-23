//
//  MovieViewModel.swift
//  MovieSearch
//
//  Created by ChunTa Chen on 9/19/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

let API_KEY:String = "328c283cd27bd1877d9080ccb1604c91"
class MovieCollection: EVObject
{
    var id:String = ""
    var name:String = ""
    var poster_path:String = ""
    var backdrop_path:String = ""
}

class Genre: EVObject
{
    var id:String = ""
    var name:String = ""
}
class MovieDetail: EVObject
{
    var backdrop_path:String = ""
    var homepage:String = ""
    var id:String = ""
    var popularity:Double = 0
    var poster_path:String = ""
    var release_date:String = ""
    var title:String = ""
    var overview:String = ""
    var original_language:String = ""
    var genres:Array<Genre> = []
    var runtime:String = ""
}

class MovieNail: EVObject
{
    var id:String = ""
    var title:String = ""
    var popularity:String = ""
    var poster_path:String = ""
    var original_language:String = ""
    var original_title:String = ""
    var genre_ids:Array<UInt> = []
    var backdrop_path:String = ""
    var overview:String = ""
    var release_date:String = ""
}

class Page: EVObject
{
    var page:UInt = 0
    var total_results:UInt = 0
    var total_pages:UInt = 0
    var results: [MovieNail] = []
}

class MovieModel
{
    class func queryPage(page:Int, withCompletionHandler:@escaping (_ :Array<MovieNail>) -> Void)
    {
        let url:String = String(format:"http://api.themoviedb.org/3/discover/movie?api_key=%@&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=%d", API_KEY, page)
        Alamofire.request(url).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let array = (Page)(json: utf8Text)
                withCompletionHandler(array.results)
            }
        }
    }
    
    class func queryMovieDetail(id:String, withCompletionHandler:@escaping (_ :MovieDetail) -> Void)
    {
        let url:String = String(format:"http://api.themoviedb.org/3/movie/%@?api_key=%@", id, API_KEY)
        Alamofire.request(url).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let detail = (MovieDetail)(json: utf8Text)
                withCompletionHandler(detail)
            }
        }
    }
}
