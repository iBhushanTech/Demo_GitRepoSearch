//
//  NetworkManager.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration
import PKHUD

class NetworkManager{
    static let shared = NetworkManager()
    var networkError: Error?

    private init(){}
    
    //MARK :- GET Request
    func GET(url:String, onSuccess:@escaping (Any?) -> Void, onFailure:@escaping (Error?) -> Void){
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers:nil).responseJSON { (response:DataResponse<Any>) in
                        
            switch(response.result) {
            case .success(_):
                
                guard let data = response.result.value else{
                    onFailure(nil)
                    return
                }
                
                onSuccess(data)
                
                break
            case .failure(_):
                onFailure(response.result.error)
                print("API URL ==>> \(url) \n \(String(describing: response.result.error))")
                break
            }
        }
    }
    
    func isInternetAvailable() -> Bool{
      var zeroAddress = sockaddr_in()
      zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
      zeroAddress.sin_family = sa_family_t(AF_INET)

      let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
          SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
      }

      var flags = SCNetworkReachabilityFlags()
      if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
      }

      let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
      let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
      return (isReachable && !needsConnection)
    }
}



func showNetworkError(on Controller: UIViewController){
    let alert = UIAlertController(title: "No Internet connection", message: "", preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
    }))
    
    PKHUD.sharedHUD.hide()
    
    if !(Controller is UIAlertController) {
        Controller.present(alert, animated: true, completion: nil)
    }
    
}
