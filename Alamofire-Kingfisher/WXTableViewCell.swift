//
//  WXTableViewCell.swift
//  Alamofire-Kingfisher
//
//  Created by hgdq on 16/5/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit
import Kingfisher
//import DataModel

class WXTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCellWiftDataArray(dataArray :NSArray, indexPath: NSIndexPath){
        let model = dataArray[indexPath.row] as! DataModel
        
        self.userImageView.kf_setImageWithURL(NSURL(string: model.userLogo)!)
        self.userNameLabel.text = model.userName
        self.timerLabel.text = model.date;
        self.mainImageView.kf_setImageWithURL(NSURL(string: model.contentImg)!)
        self.contentLabel.text = model.title
        self.typeLabel.text = model.typeName
    }
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
