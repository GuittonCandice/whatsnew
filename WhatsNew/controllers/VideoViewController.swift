//
//  VideoViewController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit
class VideoViewController: UIViewController {
    
    var videoId: String?
    var userToken: String?
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        if let userToken:String = defaults.string(forKey: Constants.USER_TOKEN_KEY)  {
            
            print("userToken \(userToken)")
            self.userToken = userToken
            
            getVideo()
            
        } else {
            self.loginAgain()
        }
        
    }
    
    func loginAgain() {
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    func getVideo() {
        
        guard let userToken = self.userToken else {
            print("Error getting user Google's token")
            return
        }
        
        guard let videoId = self.videoId else {
            print("Error getting videoId")
            return
        }
        
        let urlString = "\(Constants.VIDEO_URL)?id=\(videoId)&part=snippet,contentDetails&access_token=\(userToken)&key=\(Constants.YOUTUBE_API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
                if (httpResponse.statusCode == 401) {
                    self.loginAgain()
                }
            }
            
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(GetVideoResponse.self, from: data)
                print("Getting JSON from api : \(response)")
                
                
            } catch let errorJson {
                print(errorJson)
                return
            }
            
            }.resume()
        
    }
    
    
}
