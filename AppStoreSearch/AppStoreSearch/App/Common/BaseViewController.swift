//
//  BaseViewController.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import UIKit
import SystemConfiguration
import RxSwift

class BaseViewController<ContentView: UIView>: UIViewController, UIGestureRecognizerDelegate {
    var bag = DisposeBag()
    
    var contentView: ContentView {
        return view as! ContentView
    }
    override func loadView() {
        self.view = ContentView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.bindViewModel()
    }
    
    func bindViewModel() { }
    
    func isConnectedNetwork(_ completion: @escaping (Bool) -> Void) {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            completion(false)
            return
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            completion(false)
            return
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        completion(isReachable && !needsConnection)
    }
}

