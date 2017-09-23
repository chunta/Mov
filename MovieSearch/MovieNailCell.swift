//
//  MovieNailCell.swift
//  MovieSearch
//
//  Created by ChunTa Chen on 9/22/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//
import UIKit
import Foundation
class MovieNailCell: UITableViewCell
{
    @IBOutlet var posterImgView:UIImageView!
    @IBOutlet var backgropImgView:UIImageView!
    @IBOutlet var popularityTxt:UILabel!
    @IBOutlet var titleTxt:UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
}
