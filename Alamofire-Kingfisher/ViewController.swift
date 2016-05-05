//
//  ViewController.swift
//  Alamofire-Kingfisher
//
//  Created by hgdq on 16/5/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit
/// 包含头文件
import Alamofire
import Kingfisher
import MJRefresh
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
        /// tableView显示的数据集合
    var dataArray : NSMutableArray!
        /// 总页数
    var allPages : NSNumber!
        /// 当前有页码
    var currentPage = 1
        /// showAPI相关的参数
    let showapi_appid = "5621"
    let showapi_sign = "d701b9e0fc964d60b0ec169dad771ebd"
    let baseUrl = "https://route.showapi.com/582-2?"
    var flag = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.initView()
        self.requestData("1");
        // Do any additional setup after loading the view, typically from a nib.
    }

    func initData(){
        self.dataArray = NSMutableArray.init(array: [""])
        self.dataArray.removeAllObjects()
    }
    func initView() {
        self.tableView.registerNib(UINib(nibName: "WXTableViewCell", bundle:nil), forCellReuseIdentifier: "WXTableViewCell")
        // 添加下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(ViewController.headRefresh))
        // 添加上拉加载更多
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self,refreshingAction: #selector(ViewController.addMoreData))
    }
// MARK: 网络请求
    /**
     网络请求
     
     - parameter pageIndex: 页数
     */
    func requestData(pageIndex: String){
        self.showHUD()
        // 设置请求参数
        let showapi_timestamp = self.getDataStr()
        
        let parameters = [
            "key": "",
            "showapi_appid": showapi_appid,
            "showapi_sign": showapi_sign,
            "page": pageIndex,
            "showapi_timestamp": showapi_timestamp,
            ]
        
        Alamofire.request(.GET, baseUrl, parameters: parameters).responseJSON {response in
            switch response.result{
            case .Success(let dice):
                self.hideHUD()
                let dice1 = dice["showapi_res_body"] as! NSDictionary
                let dice2 = dice1["pagebean"] as! NSDictionary
                self.allPages = dice2["allPages"] as! NSNumber
                let contentlist = dice2["contentlist"] as! NSArray
            
                // 下拉刷新 数组清空
                if pageIndex == "1"{
                    self.dataArray.removeAllObjects()
                }
                for dataDice in contentlist{
                    let model = DataModel()
                    // 数据转模型  添加进数组
                    self.dataArray.addObject(model.makeDataModel(dataDice as! NSDictionary))
                }
                self.flag = 2
                self.tableView.reloadData()
                // 刷新完成  结束上下拉
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                
            case .Failure(let error):
               print(error)
               self.hideHUD()
            }
        }
    }
    
    
// MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.flag == 1 {
            return 1
        }
        else{
            return self.dataArray.count
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identify:String = "WXTableViewCell"
        let cell:WXTableViewCell = tableView.dequeueReusableCellWithIdentifier(identify) as! WXTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if self.flag == 2 {
            cell.fillCellWiftDataArray(self.dataArray, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.flag == 2 {
            let model = self.dataArray[indexPath.row] as! DataModel
            let dVC = DetailViewController()
            dVC.detailURL = model.url
            self.navigationController?.pushViewController(dVC, animated: true)
        }
    }
// MARK: 上下拉
    /**
     下拉刷新
     */
    func headRefresh() {
        self.requestData("1")
    }
    /**
     上拉加载更多
     */
    func addMoreData() {
        self.currentPage = self.currentPage + 1
        if self.currentPage < self.allPages.integerValue {
            let page = String(self.currentPage)
            self .requestData(page)
        }
    }
// MARK: 菊花
    func showHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = "数据加载中……"
        hud.dimBackground = true
    }
    func hideHUD() {
       MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    

    /**
     获取当前时间
     
     - returns: 当前时间
     */
    func getDataStr() -> String{
        let date1 = NSDate()
        let dataFormat = NSDateFormatter.init()
        // yyyyMMddHHmmss
        dataFormat.dateFormat = "yyyyMMddHHmmss"
        let dataString = dataFormat.stringFromDate(date1) as String
        return dataString
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


















