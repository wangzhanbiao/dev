//
//  ViewController.swift
//  Demo
//
//  Created by wangzhanbiao on 16/3/9.
//  Copyright © 2016年 pagoda. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,SmallCellDelegate,UITableViewDelegate,UITableViewDataSource{
    
    // MARK:-变量
    var buttonArr:NSMutableArray?
    var number:Int = 0
    var myTableView:UITableView!
    var time:Timer?
    var totleTime:TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonArr = NSMutableArray()
        self.view.backgroundColor = UIColor.white
        myTableView = UITableView()
        myTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 200)
        myTableView.backgroundColor = UIColor.white
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
        myTableView.contentOffset = CGPoint(x: 0, y: CGFloat(number*75))
        myTableView.showsVerticalScrollIndicator = false
        myTableView.bounces = false
        myTableView.isScrollEnabled = false
        myTableView.register(SmallCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func didClick(_ button:UIButton){
        
        let cell = button.superview?.superview as! SmallCell
        cell.button?.isUserInteractionEnabled = false
        let indexPath:IndexPath = myTableView.indexPath(for: cell)!
        if indexPath.row == number-1 {
            if time == nil {
                time = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:#selector(onTimeing(_:)), userInfo: nil, repeats: true)
            }
        }
        
        var nextCell:SmallCell?
        if indexPath.row - 1 >= 0 {
            nextCell = myTableView.cellForRow(at: IndexPath.init(row: indexPath.row - 1, section: indexPath.section)) as? SmallCell
        }
        
        if nextCell != nil {
            nextCell!.button!.isUserInteractionEnabled = true
        }
        if indexPath.row == 0 {
            self.showAlert()
        }
        let point = myTableView.contentOffset
        myTableView.contentOffset = CGPoint(x: 0, y: point.y - 75)
        
    }
    
    func gameOver(){
        time?.invalidate()
        time = nil
        
        let alertController = UIAlertController.init(title: "", message: "Game Over", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            self.navigationController!.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(){
        time?.invalidate()
        time = nil
        
        let alertController = UIAlertController.init(title: "TotleTime", message: String(totleTime), preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            
            let timeStr:String = "\(self.totleTime)"
            let record = RecordManager.sharedInstance
            record.saveRecord(timeStr, key: String(self.number))
            self.navigationController!.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onTimeing(_ time:Timer) {
        totleTime = totleTime + time.timeInterval
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return number
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SmallCell
        cell.delegate = self
        let button = cell.button
        if indexPath.row == number-1 {
            button?.isUserInteractionEnabled = true
        }
        return cell
    }
}

