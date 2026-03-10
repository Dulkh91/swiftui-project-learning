//
//  Utilities.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 9/3/26.
//

import Swift
import Foundation
import UIKit

final class Utilities {
    static var shared = Utilities()
    private init() {}
    
    func topViewController(controller: UIViewController? = nil)-> UIViewController?{
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.topViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            return topViewController(controller: tabController.selectedViewController)
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
