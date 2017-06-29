//
//  ViewController.swift
//  WebBrowser
//
//  Created by Samtech on 10-05-17.
//  Copyright © 2017 Samtech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              // Do any additional setup after loading the view, typically from a nib.
        self.title = "ViewController"
        var url = URL(string: "https://www.samtech.cl/ANDROID/index.asp?v=1")
        if UserDefaults.standard.string(forKey: "jsonDatas") != nil {
            
            let datos = UserDefaults.standard.string(forKey: "jsonDatas")?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            //datos = "&data={\"data\":\"aaaaaaaaaa\",\"mesa\":\"mesaaaa\"}".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            url = URL(string: "https://www.samtech.cl/ANDROID/index.asp?v=2&token="+UserDefaults.standard.string(forKey: "token")!+"&data="+datos!)
        }else if UserDefaults.standard.string(forKey: "token") != nil {
            url = URL(string: "https://www.samtech.cl/ANDROID/index.asp?v=3&token="+UserDefaults.standard.string(forKey: "token")!)
        }
        let request = URLRequest(url: url!)
        webView.scrollView.minimumZoomScale = 1.0;
        webView.scrollView.maximumZoomScale = 1.0;
        webView.loadRequest(request)
        
    }



}

 
