//
//  BaseVC.swift
//  Cabtown Use
//
//  Created by Elluminati iMac on 10/05/17.
//  Copyright © 2017 Elluminati iMac. All rights reserved.
//

import UIKit
//import Alamofire

class BaseVC: UIViewController
{
    
    //MARK:
    //MARK: View life cycle
    
    deinit {
        print("\(self) \(#function)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
     }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
      //  self.setupNetworkReachability()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: APPDELEGATE.reachability)
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNetworkReachability()
    {
        
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: APPDELEGATE.reachability)
    }
    
//    @objc func reachabilityChanged(note: NSNotification)
//    {
//        
//        let reachability = note.object as! Reachability
//        
//        if reachability.isReachable
//        {
//            self.networkEstablishAgain()
//        }
//        else
//        {
//            self.networklost()
//            
//        }
//    }
    func networkEstablishAgain()
    {
        print("\(self.description) Network reachable")
    }
    func networklost()
    {
        print("\(self.description) Network not reachable")
    }
    
//    func changed(_ language: Int) {
//        var transition: UIView.AnimationOptions = .transitionFlipFromLeft
//        LocalizeLanguage.setAppleLanguageTo(lang: language)
//
//        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        }
//        else {
//            transition = .transitionFlipFromRight
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        }
//
//        Alamofire.SessionManager.default.session.cancelTasks { [unowned self] in
//            let appWindow: UIWindow? = APPDELEGATE.window
//            let vC: UIViewController? = self.storyboard?.instantiateInitialViewController()
//
//            appWindow?.removeFromSuperviewAndNCObserver()
//            appWindow?.rootViewController?.removeFromParentAndNCObserver()
//            appWindow?.rootViewController = vC
//            appWindow?.makeKeyAndVisible()
//            appWindow?.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//
//            UIView.transition(with: appWindow ?? UIWindow(),
//                              duration: 0.5,
//                              options: transition,
//                              animations: { () -> Void in
//            }) { (finished) -> Void in
//                appWindow?.backgroundColor = UIColor.clear
//            }
//        }
//    }
//
}
extension UIViewController
{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

public class Model {
    deinit {
        print("\(self) \(#function)")
    }
}

public class ModelNSObj: NSObject {
    deinit {
        print("\(self) \(#function)")
    }
}

public class CustomDialog: UIView {
    deinit {
        print("\(self) \(#function)")
    }
}

public class TblVwCell: UITableViewCell {
    deinit {
        print("\(self) \(#function)")
    }
}

public class CltVwCell: UICollectionViewCell {
    deinit {
        print("\(self) \(#function)")
    }
}
