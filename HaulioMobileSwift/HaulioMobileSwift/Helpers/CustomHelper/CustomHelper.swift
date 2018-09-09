//
//  CustomHelper.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import Foundation
class CustomHelper{
    
    static let shared = CustomHelper()
    
    init(){}
    
    func saveToNSUserDefaultWithKey(key:String,value:String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getFromNSUserDefaultWithKey(key:String) -> String{
        return UserDefaults.standard.value(forKey: key) as! String
    }
}
