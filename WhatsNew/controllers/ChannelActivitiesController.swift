//
//  ChannelDetailController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit
import Kingfisher

class ChannelActivitiesController: UITableViewController {
    
    var userToken: String?
    var channelId: String?
    var smallUrl: String?
    let maxActivities = 25
    
    var videos: [ChannelActivityItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
        guard channelId != nil else {return}
        
        print("ChannelActivitiesController, channelId = \(String(describing: channelId))")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = videos?.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelActivityCell", for: indexPath) as! ChannelActivityCell
        
        guard let videos = videos else { return cell}
        
        guard "upload" == videos[indexPath.row].snippet.type else {return cell}
        
        cell.ibTitleLabel.text = videos[indexPath.row].snippet.title
        cell.descriptionLabel.text = videos[indexPath.row].snippet.description
        
        let url = URL(string: videos[indexPath.row].snippet.thumbnails.medium.url)
        
        if let smallUrl = self.smallUrl {
            let smallUrlResource = URL(string: smallUrl)
            cell.avatarImageView.kf.setImage(with: smallUrlResource)
            
            // Circular imageView
            cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height / 2
            cell.avatarImageView.layer.masksToBounds = false
            cell.avatarImageView.clipsToBounds = true
        }
        
        
        cell.ibImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        if let userToken:String = defaults.string(forKey: Constants.USER_TOKEN_KEY)  {
            
            print("userToken \(userToken)")
            self.userToken = userToken
            
            getRecentChannelsUpdates()
            
        } else {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
        
    }
    
    func loginAgain() {
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    func getRecentChannelsUpdates() {
        
        guard let userToken = self.userToken else {
            print("Error getting user Google's token")
            return
        }
        
        guard let channelId = self.channelId else {
            print("Error getting channelId")
            return
        }
        
        let urlString = "\(Constants.CHANNEL_ACTIVITIES_URL)?channelId=\(channelId)&part=snippet,contentDetails&maxResults=\(maxActivities)&access_token=\(userToken)&key=\(Constants.YOUTUBE_API_KEY)"
        
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
                let response = try decoder.decode(GetChannelActivityResponse.self, from: data)
                print("Getting JSON from api : \(response)")
                
                self.videos = response.items
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch let errorJson {
                print(errorJson)
                return
            }
            
            }.resume()
 
    }
}

