//
//  SmallCell.swift
//  Demo
//
//  Created by wangzhanbiao on 16/3/31.
//  Copyright © 2016年 pagoda. All rights reserved.
//

import UIKit

protocol SmallCellDelegate:NSObjectProtocol {
    func didClick(_ button:UIButton)
    func gameOver()
}

class SmallCell: UITableViewCell {
    
    weak var delegate:SmallCellDelegate?;
    var button:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.initSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews(){
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 75))
        view.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchEvent))
        view.addGestureRecognizer(tap)
        self.addSubview(view)
        
        let width = view.frame.size.width/3
        let height = view.frame.size.height
        let i = arc4random() % 3
        let x = width * CGFloat(i)
        let y:CGFloat = 0
        
        button = UIButton.init(frame: CGRect(x: x, y: y, width: width, height: height))
        button!.backgroundColor = UIColor.blue
        button!.isUserInteractionEnabled = false
        button!.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        view .addSubview(button!)
    }
    
    func onClick(_ button:UIButton) {
        if delegate != nil {
            delegate?.didClick(button)
        }
    }
    
    func touchEvent()  {
        if delegate != nil {
            delegate?.gameOver()
        }
    }
}
