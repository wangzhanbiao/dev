//
//  MainViewController.swift
//  Demo
//
//  Created by wangzhanbiao on 16/3/31.
//  Copyright © 2016年 pagoda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "最高纪录", style: .plain, target: self, action:#selector(onRecord))
        self.initSubviews()
    }
    
    func initSubviews() {
        let arr = NSMutableArray()
        for i in 0 ..< 4 {
            let bum = (i+1)*10
            arr.add(String(bum))
            let x = (self.view.frame.size.width - 200)/2
            let starButton = UIButton.init(frame: CGRect(x: x, y: 100*(CGFloat(i) + 1), width: 200, height: 50))
            starButton.tag = bum
            starButton.setTitle(String(bum), for: UIControlState())
            starButton.backgroundColor = UIColor.orange
            starButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
            let line = UIImageView.init(image: PagodaImageHelper.image(with: UIColor.blue))
            line.frame = CGRectFromString("{{0, 49}, {200, 1}}")
            starButton.addSubview(line)
            self.view.addSubview(starButton)
        }
        let record = RecordManager.sharedInstance
        record.saveKey(NSArray.init(array: arr))
    }
    
    func onRecord() {
        let recordVC = RecordTableViewController()
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
    
    func startGame(button:UIButton?) {
        let vc = GameViewController()
        vc.number = (button?.tag)!;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
