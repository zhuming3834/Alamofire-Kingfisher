//
//  DataModel.swift
//  Alamofire-Kingfisher
//
//  Created by hgdq on 16/5/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class DataModel: NSObject {
     /// 内容主图
    var contentImg: String!
     /// 时间
    var date: String!
     /// 文章id
    var id: String!
     /// 文章的标题
    var title: String!
     /// 文章类型id
    var typeId: String!
     /// 文章类型名
    var typeName: String!
     /// 文章链接
    var url: String!
     /// 用户头像
    var userLogo: String!
     /// 用户二维码
    var userLogo_code: String!
     /// 用户名
    var userName: String!
    
    /**
     字典数据封装成数据模型
     
     - parameter dice: 字典数据源
     
     - returns: 数据模型
     */
    func makeDataModel(dice : NSDictionary) -> DataModel {
        let model = DataModel()
        model.contentImg = dice["contentImg"] as! String
        model.date = dice["date"] as! String
        model.id = dice["id"] as! String
        model.title = dice["title"] as! String
        model.typeId = dice["typeId"] as! String
        model.typeName = dice["typeName"] as! String
        model.url = dice["url"] as! String
        model.userLogo = dice["userLogo"] as! String
        model.userLogo_code = dice["userLogo_code"] as! String
        model.userName = dice["userName"] as! String
        return model
    }
}


















