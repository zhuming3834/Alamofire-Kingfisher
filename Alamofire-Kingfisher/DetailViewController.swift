//
//  DetailViewController.swift
//  Alamofire-Kingfisher
//
//  Created by hgdq on 16/5/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailViewController: UIViewController, UIWebViewDelegate{

    var detailURL : String!
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: self.detailURL)!))
        // Do any additional setup after loading the view.
    }
// MARK: UIWebViewDelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.showHUD()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.hideHUD()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.hideHUD()
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
