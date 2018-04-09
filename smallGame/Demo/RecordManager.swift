//
//  RecordManager.swift
//  Demo
//
//  Created by wangzhanbiao on 16/4/6.
//  Copyright © 2016年 pagoda. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class RecordManager: NSObject {
    
    static let sharedInstance = RecordManager()
    private override init() {}

    var numArr:NSArray?
    var timeArray:NSArray?{
        get{
            let arr:NSMutableArray = NSMutableArray()
            for str in numArr! {
                
                arr.add(UserDefaults.standard.object(forKey: str as! String)!)
            }
            return arr
        }
    }
    var dic:NSMutableDictionary? = NSMutableDictionary()
    
    func saveKey(_ array:NSArray) {
        numArr = array
        let userDefaults = UserDefaults.standard
        for str in array {
            if (userDefaults.object(forKey: str as! String) == nil) {
                userDefaults.setValue("0", forKey: str as! String)
            }
        }
    }
    
    func saveRecord(_ value:String , key:String) {
        let lastRecord = UserDefaults.standard.object(forKey: key) as! String
        let currentRecord = value
        if lastRecord == "0" {
            UserDefaults.standard.setValue(value, forKey: key)
        }
        if Double.init(currentRecord) < Double.init(lastRecord) {
            UserDefaults.standard.setValue(value, forKey: key)
        }
    }

}
