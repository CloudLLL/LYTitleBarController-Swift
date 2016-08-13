//
//  LYTitleBarController.swift
//  LYTitleBarController-Swift

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

///指示器样式
enum IndicatorStyle{
    ///矩形
    case frame
    ///条形
    case bar
    ///点形
    case point
}

///指示器滚动模式
enum IndicatorScrollMode{
    ///跟随cell滚动而滚动
    case follow
    ///cell停止滚动后滚动
    case delay
    
}

let screenW = UIScreen.mainScreen().bounds.size.width
let screenH = UIScreen.mainScreen().bounds.size.height

class LYTitleBarController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    ///导航条高度
    var titleBarHeight : CGFloat = 44
    ///导航条Y值
    var titleBarY : CGFloat = 64
    ///导航条的背景颜色
    var titleBarBackgroundColor : UIColor?
    ///导航条底部分割线颜色
    var titleBarLineBackgroundColor : UIColor?
    ///一次最多显示的标题个数
    var maxTitleCount : Int = 5
    ///标题文字颜色
    var titleColor : UIColor?
    ///标题文字选中颜色
    var titleSeleSelectedColor : UIColor?
    ///指示器背景颜色
    var indicatorBackgroundColor : UIColor?
    ///指示器样式
    var indicatorStyle : IndicatorStyle = .frame
    ///指示器条形样式的高度
    var indicatorBarStyleHeight : CGFloat = 5
    ///指示器点形样式的半径
    var indicatorPointStyleRadius : CGFloat = 4
    ///指示器矩形样式是与按钮宽度的差值
    var indicatorFrameStylePoorWight : CGFloat = 10
    ///指示器矩形样式是与按钮高度的差值
    var indicatorFrameStylePoorHeight : CGFloat = 10
    ///指示器的滚动模式
    var indicatorScrollMode : IndicatorScrollMode = .follow
    ///跑马灯效果:默认开启
    var randomTitleBarBackgroundColor :Bool = true
    var randomIndicatorBackgroundColor :Bool = true
    ///指示器矩形样式的圆角半径 默认为指示器高度的一半
    var indicatorFrameStyleRadius : CGFloat = 0
    
    private static let cellID  = "cell"
    private var collecView : UICollectionView?
    private var titleBar : UIScrollView?
    private var btns : [UIButton] = [UIButton]()
    private var indicatorView : UIView?
    private var selectedBtn : UIButton?
    private var offSetX : CGFloat = 0
    private var num : Int = 0
    private var titleBtnW : CGFloat  {
        
        if maxTitleCount > self.childViewControllers.count{
            
            return screenW / CGFloat ( self.childViewControllers.count)
            
        }else{
        
            return screenW / CGFloat ( maxTitleCount )
            
        }
        
        
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addCollectionView()
        
    }
    //MARK: - viewDidAppear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard num == 0 else{
        
            return
        }
        
        addTitleBarView()
        
        addlineView()
        
        addTitleBtn()
    
        num += 1
    }
    
    
    //MARK: - 添加指示器
    func addIndicatorView(){
        
        let indicatorView = UIView()
        
        if indicatorBackgroundColor == nil{
            
            indicatorBackgroundColor = UIColor.yellowColor()
        
        }
        indicatorView.backgroundColor = indicatorBackgroundColor
        
        self.indicatorView = indicatorView
        
        titleBar?.addSubview(indicatorView)
        
        switch indicatorStyle{
            
        case .frame:
            indicatorView.frame = CGRect(x: indicatorFrameStylePoorWight * 0.5, y: indicatorFrameStylePoorHeight * 0.5, width: titleBtnW - indicatorFrameStylePoorWight, height: titleBarHeight - indicatorFrameStylePoorHeight)
            if indicatorFrameStyleRadius == 0 {
            
                indicatorFrameStyleRadius = (self.titleBarHeight - indicatorFrameStylePoorHeight) * 0.5
            }
            indicatorView.layer.cornerRadius = indicatorFrameStyleRadius

        case .bar:
            indicatorView.frame =  CGRect(x: 0, y: titleBarHeight - indicatorBarStyleHeight, width: titleBtnW, height: indicatorBarStyleHeight)

        case .point:
            indicatorView.frame = CGRect(x: titleBtnW * 0.5 - indicatorPointStyleRadius, y: titleBarHeight - indicatorPointStyleRadius * 2, width: indicatorPointStyleRadius * 2, height: indicatorPointStyleRadius * 2)
            indicatorView.layer.cornerRadius = indicatorPointStyleRadius

        }
        
    }
    
    //MARK: - 添加按钮
    func addTitleBtn(){
        
        let h = titleBarHeight
        
        for  i in 0 ..< (self.childViewControllers.count){
            
            let btn = UIButton(type: .Custom)
            
            btn.frame = CGRect(x: CGFloat(i) * titleBtnW, y: 0, width: titleBtnW, height: h)
            
            if titleColor == nil{
            
                titleColor = UIColor.blackColor()
            }
            
            btn.setTitleColor(titleColor, forState: .Normal)
            
            if titleSeleSelectedColor == nil{
            
                titleSeleSelectedColor = UIColor.redColor()
            }
            
            btn.setTitleColor(titleSeleSelectedColor, forState: .Selected)
            
            btn.setTitle(self.childViewControllers[i].title, forState: .Normal)
            
            btn.addTarget(self, action:"titleBtnClick:", forControlEvents: .TouchUpInside)
            
            btn.tag = i
            
            if i == 0{
                
                btn.selected = true
                
                selectedBtn = btn
                
                addIndicatorView()
                
            }
            
            titleBar?.addSubview(btn)
            
            btns.append(btn)
            
        }
        
        titleBar?.contentSize = CGSize(width: titleBtnW * CGFloat(self.childViewControllers.count), height: 0)
        
    }
    
    //MARK: - titleBtn点击
    func titleBtnClick(btn : UIButton){
        
        selectedBtn?.selected  = false
        
        btn.selected = true
        
        selectedBtn = btn
        
        let offSetX = CGFloat(btn.tag) * screenW
        
        collecView?.contentOffset.x = offSetX
        
        
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.indicatorView?.center.x = btn.center.x
            
            if self.randomIndicatorBackgroundColor == true{
                
                let r = CGFloat(arc4random_uniform(255)) / 255.0
                let g = CGFloat(arc4random_uniform(255)) / 255.0
                let b = CGFloat(arc4random_uniform(255)) / 255.0
                
                self.indicatorView?.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
                
            }
        }
        
        var scrollOffSetX = btn.center.x - screenW * 0.5
        
        if scrollOffSetX < 0 {
            
            scrollOffSetX = 0
            
        }
        
        if scrollOffSetX > (titleBar?.contentSize.width)! - screenW {
            
            scrollOffSetX = (titleBar?.contentSize.width)! - screenW
            
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.titleBar?.contentOffset = CGPoint(x: scrollOffSetX, y: 0)
            
            if self.randomTitleBarBackgroundColor == true{
                
                let r = CGFloat(arc4random_uniform(255)) / 255.0
                let g = CGFloat(arc4random_uniform(255)) / 255.0
                let b = CGFloat(arc4random_uniform(255)) / 255.0
                
                self.titleBar?.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
                
            }
        }
        
        
        
    }
    
    
    //MARK: -  添加导航条
    func addTitleBarView(){
        
        let titleBar = UIScrollView()
        
        view.addSubview(titleBar)
        
        self.titleBar = titleBar
        
        titleBar.frame = CGRect(x: 0, y: titleBarY, width: screenW, height: titleBarHeight)
        
        titleBar.scrollsToTop = false
        
        titleBar.showsHorizontalScrollIndicator = false
        
        titleBar.showsVerticalScrollIndicator = false
        
        if titleBarBackgroundColor == nil{
            
            titleBarBackgroundColor = UIColor.whiteColor()
        }
        
        titleBar.backgroundColor = titleBarBackgroundColor
        
    }
    
    //MARK: - 添加分割线
    func addlineView(){
        
        // TODO: 添加分割线
        
        let lineView = UIView()
        
        lineView.frame = CGRect(x: 0, y: titleBarHeight - 1, width: titleBtnW * CGFloat(self.childViewControllers.count), height: 1)
        
        if titleBarLineBackgroundColor == nil{
            
            titleBarLineBackgroundColor = UIColor.lightGrayColor()
        }
        
        lineView.backgroundColor = titleBarLineBackgroundColor
        
        lineView.alpha = 0.3
        
        titleBar?.addSubview(lineView)
        
    }
    
    
    //MARK: - 添加collectionView
    func addCollectionView(){
        
        let flow :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        flow.minimumInteritemSpacing = 0
        
        flow.minimumLineSpacing = 0
        
        flow.scrollDirection = .Horizontal
        
        flow.itemSize = UIScreen.mainScreen().bounds.size
        
        
        let collecView = UICollectionView(frame: UIScreen.mainScreen().bounds,collectionViewLayout: flow)
        
        self.collecView = collecView
        
        view.addSubview(collecView)
        
        collecView.backgroundColor = UIColor.yellowColor()
        
        self.collecView?.delegate = self
        
        self.collecView?.dataSource = self
        
        collecView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: LYTitleBarController.cellID)
        
        collecView.pagingEnabled = true
        
        collecView.scrollsToTop = false
        
        collecView.showsHorizontalScrollIndicator = false
        
        collecView.showsVerticalScrollIndicator = false
        
        collecView.bounces = false
        
        
    }
    //MARK: - collection数据源
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collecView?.dequeueReusableCellWithReuseIdentifier(LYTitleBarController.cellID, forIndexPath: indexPath)
        
        cell?.addSubview(self.childViewControllers[indexPath.row].view)
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    
    //MARK: - collection代理
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / screenW
        
        let btn = btns[Int(index)]
        
        titleBtnClick(btn)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if indicatorScrollMode == .follow{
            
            let tmpe = scrollView.contentOffset.x / screenW * titleBtnW
            
            let x = tmpe - offSetX
            
            offSetX = tmpe
            
            self.indicatorView?.center.x += x
            
        }
    }
}


