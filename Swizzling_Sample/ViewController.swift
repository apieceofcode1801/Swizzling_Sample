//
//  ViewController.swift
//  Swizzling_Sample
//
//  Created by Trung Hoang on 20/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        UIButton.xxx_swizzleSendAction()
        super.viewDidLoad()
    }
    
    @IBAction func tapOnButton() {
        print("Button tapped")
    }
}

extension UIButton {
    class func xxx_swizzleSendAction() {
        struct xxx_swizzleToken {
            static var onceToken : Int = 0
        }
        
        let cls: AnyClass! = UIButton.self
        
        let originalSelector = #selector(sendAction(_:to:for:))
        let swizzledSelector = #selector(xxx_sendAction(_:to:for:))
        
        guard let originalMethod =
                class_getInstanceMethod(cls, originalSelector), let swizzledMethod =
                class_getInstanceMethod(cls, swizzledSelector) else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    @objc public func xxx_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?)
    {
        struct xxx_buttonTapCounter {
            static var count: Int = 0
        }
        
        xxx_buttonTapCounter.count += 1
        print(xxx_buttonTapCounter.count)
        xxx_sendAction(action, to: target, for: event)
    }
}
