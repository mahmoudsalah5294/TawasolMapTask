//
//  ViewController.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 13/11/2021.
//

import UIKit
import WebKit
class ViewController: UIViewController,WKNavigationDelegate{

    
    @IBOutlet weak var loginWebView: WKWebView!
    
    
    override func loadView() {
        let webViewConfig = WKWebViewConfiguration()
        loginWebView = WKWebView(frame: .zero, configuration: webViewConfig)
        loginWebView.navigationDelegate = self
        view = loginWebView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginWebView.allowsLinkPreview = true
        loginWebView.load(URLRequest(url: URL(string: "http://gps.tawasolmap.com/login.html")!))
}
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        let access_token = navigationResponse.response.url?.description.components(separatedBy: "access_token=")
        if access_token!.count > 1{
            var token = access_token?[1].components(separatedBy: "&")[0] ?? ""
            
            token = "\"\(token)\""
            guard let dataVC = storyboard?.instantiateViewController(withIdentifier: "dataStoryBoard") as? UnitsTableViewController
            else { return }
            dataVC.modalPresentationStyle = .fullScreen
            dataVC.token = token
            present(dataVC, animated: true, completion: nil)
        print("token value: \(token)")
        }
    }
}
