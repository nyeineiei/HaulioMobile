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
    override func viewDidLoad() {
        super.viewDidLoad()

        let catPictureURL = URL(string: CustomHelper.init().getFromNSUserDefaultWithKey(key: "user_img"))!
        let data = try? Data(contentsOf: catPictureURL)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.imgProfile.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
