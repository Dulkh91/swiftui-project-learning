//
//  Utilities.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//


import Foundation
import UIKit

final class Utilities{
    static var shared = Utilities()
    init(){}
    
    // សម្រាប់ស្វែងរក View Controller ដែលកំពុងបង្ហាញនៅលើអេក្រង់ខាងលើគេបង្អស់
    func topViewController(controller: UIViewController? = nil) -> UIViewController?{
        let rootVC = controller ?? UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow })?.rootViewController
        
        // ប្រសិនបើជួប UINavigationController ត្រូវលូនទៅរក ViewController ចុងក្រោយគេ
        if let navigationController = rootVC as? UINavigationController{
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        // ប្រសិនបើជួប UITabBarController ត្រូវលូនទៅរក Tab ដែលកំពុងបើក
        if let tabController = rootVC as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        // ប្រសិនបើជួបផ្ទាំងដែលកំពុង Modal Present (Popup) ត្រូវលូនទៅរកផ្ទាំង Popup នោះ
        if let presented = rootVC?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return rootVC
    }
    
}
