//
//  ViewController.swift
//  webSiteTest
//
//  Created by Rose on 2021/3/18.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var mForwardBtn: UIButton!
    @IBOutlet weak var mBackBtn: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    //var mWebView: WKWebView? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = URL(string: "https://www.google.com.tw/")
        let request = URLRequest(url: url!)
        webView.load(request)

        
    }
    
    // 網頁載入開始
    func webView(_ webView: WKWebView, didStartProvisionalNavigtion navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
    }
    // 網頁載入失敗，可印出失敗原因並執行相對應之行為
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    // 網頁載入完畢
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        print("finish to load")
        if let webView = webView {
            mForwardBtn.isEnabled = webView.canGoForward
            mBackBtn.isEnabled = webView.canGoBack
        }
    }

    
    // 連結 電影網 target = "_blank" 的網頁
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
     
        // 若 target="_blank"，targetFrame 會 = nil
        if navigationAction.targetFrame == nil {
            // 傳入 .cancel 停止 navigation 預設的行為
            decisionHandler(.cancel)
            webView.load(navigationAction.request)
            return
        }
        decisionHandler(.allow)
    }
    
    
    // 實現回到上一頁和前往下一頁的功能
    @IBAction func backAction(_ sender: UIButton) {
        if webView?.goBack() == nil {
                    print("No more page to back")
                }
    }

    @IBAction func forwardAction(_ sender: UIButton) {
        if webView?.goForward() == nil {
            print("No more page to forward")
        }
    }

}

