//
//  NetworkHelper.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper{
    
    static let shared = NetworkHelper()
    
    init(){}
    
    func requestJobList(completion: @escaping (_ result: Any) -> Void) {
        Alamofire.request("https://api.myjson.com/bins/8d195.json").responseJSON { response in
            if let json = response.result.value {
                completion(json)
            }
        }
        
    }
    
//    func requestJobList(){
//        Alamofire.request("https://api.myjson.com/bins/8d195.json").responseJSON { response in
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//        }
//    }
    
}
