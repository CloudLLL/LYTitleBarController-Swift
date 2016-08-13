//
//  ViewController.swift
//  LYTitleBarController-Swift
//
//  Created by CloudL on 16/8/13.
//  Copyright © 2016年 CloudL. All rights reserved.
//

/*
怎么使用: LYTitleBarController
1.继承后,添加子控制器就行并设置控制器View的Frame*必须添加子控制器,不设置frame可能出现一些异常

2.添加控制器的时候需要设置控制器的title,不然标题为空

3.其他属性可设可不设,不设都会初始化默认值

注意点:展示内容的控制器View请自行根据导航条的高度和状态栏高度计算Frame

如果控制器的View为tableView或者继承自scrollView的View想要穿透效果,可以把frame设置为屏幕的bounds,再设置contentInset属性实现

PS:在使用中遇到什么BUG或者你有什么好的建议或者意见欢迎联系378018674@qq.com进行探讨!

OC版 github下载地址:https://github.com/kakaxixixi/LYTitleBarController
*/

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

