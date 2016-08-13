//
//  ViewController.swift
//  LYTitleBarController-Swift
//
//  Created by CloudL on 16/8/13.
//  Copyright © 2016年 CloudL. All rights reserved.
//



import UIKit

class ViewController: LYTitleBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        for i in 0...10{
            
            let vc = UIViewController()
            
            vc.title = "第\(i)页"
            
            let r = CGFloat(arc4random_uniform(255)) / 255.0
            let g = CGFloat(arc4random_uniform(255)) / 255.0
            let b = CGFloat(arc4random_uniform(255)) / 255.0
            vc.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            
            self.addChildViewController(vc)
        }
        
        self.maxTitleCount = 5
        
//          self.titleBarBackgroundColor = UIColor.greenColor()
        
//          self.indicatorScrollMode = .delay
        
            self.indicatorStyle = .bar
        
            self.indicatorBackgroundColor = UIColor.blueColor()
        
//          self.randomIndicatorBackgroundColor = false
//        
//          self.randomTitleBarBackgroundColor = false
        
//          self.indicatorFrameStyleRadius = 10
              
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

