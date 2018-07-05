//
//  ViewController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 03/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scope: NSString = "https://www.googleapis.com/auth/youtube.readonly"
        let currentScopes: NSArray = GIDSignIn.sharedInstance().scopes! as NSArray
        GIDSignIn.sharedInstance().scopes = currentScopes.adding(scope)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        let idToken = user.authentication.accessToken
        let defaults = UserDefaults.standard
        
        defaults.set(idToken, forKey: Constants.USER_TOKEN_KEY)
        
        dismiss(animated: true, completion: nil)
    }

}

