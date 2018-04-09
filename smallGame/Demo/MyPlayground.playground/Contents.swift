//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class Responder: NSObject {
    func tap() {
        print("Button pressed")
    }
}
let responder = Responder()

let button = UIButton(type: .system)
button.setTitle("Button", for: .normal)
button.addTarget(responder, action: #selector(responder.tap), for: .touchUpInside)
button.sizeToFit()
button.center = CGPoint(x: 100, y: 25)
button.backgroundColor = UIColor.lightGray

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.white
view.addSubview(button)

PlaygroundSupport.PlaygroundPage.current.liveView = view;
