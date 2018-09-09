//
//  UserProfileVC.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblJobID: UILabel!
    
    var viewData:Any!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        let catPictureURL = URL(string: CustomHelper.init().getFromNSUserDefaultWithKey(key: "user_img"))!
        let data = try? Data(contentsOf: catPictureURL)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.imgProfile.image = image
        }
        
        self.lblDriverName.text = CustomHelper.init().getFromNSUserDefaultWithKey(key: "user_given_name")
        
        let d = self.viewData as! Dictionary<String, Any>
        let jobid:NSInteger = d["job-id"] as! NSInteger
        self.lblJobID.text = String(jobid)
    }
    
    func setData(data:Any) {
        self.viewData = data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
