//
//  RecordTableViewController.swift
//  Demo
//
//  Created by wangzhanbiao on 16/4/6.
//  Copyright © 2016年 pagoda. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {
    
    let record:RecordManager = RecordManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    //MARK:-UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = record.numArr![indexPath.row] as? String
        
        let time:String = "\(record.timeArray![indexPath.row])"
        cell.detailTextLabel?.text = time;
        print(time)
        return cell
    }
    
}
