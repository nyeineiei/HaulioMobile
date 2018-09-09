//
//  LoginVC.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = "411711802398-qd12rn4v38evurhmeb3m0gjqifglljrk.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            if((user) != nil){
                CustomHelper.init().saveToNSUserDefaultWithKey(key: "user_given_name", value: user.profile.name)
                if(user.profile.hasImage){
                    CustomHelper.init().saveToNSUserDefaultWithKey(key: "user_img", value:user.profile.imageURL(withDimension: 300).absoluteString)
                }
                
                
                //Push JobsVC
                let jobsVC = JobsVC(nibName: "JobsVC", bundle: nil)
                self.navigationController!.pushViewController(jobsVC, animated: true)
            }
            
            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            //            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            //            let email = user.profile.email
            // ...
        }
    }

}
