//
//  AddPollAVPVC_PlayTrailer_Movie.swift
//  Decide With Friends
//
//  Created by Zac Moulton on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class AddPollAVPVC_PlayTrailer_Movie: UITableViewController {
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        //pollTitle.text = movie?.title
        super.viewDidLoad()
        
        let html = movie?.trailer
        let webView = UIWebView()
        webView.loadHTMLString(html!, baseURL: nil)
    }
}