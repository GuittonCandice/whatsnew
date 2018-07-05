//
//  ViewController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 03/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userToken: String?
    
    var channels: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 200
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = channels?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as! HomeControllerTableViewCell
        
        guard let channels = channels else { return cell}
        
        cell.title.text = channels[indexPath.row].snippet.title
        cell.ibDescriptionLabel.text = channels[indexPath.row].snippet.description
        
        return cell
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
        let urlString = "\(Constants.CHANNELS_LIST_URL)?mine=true&part=snippet,contentDetails&access_token=\(userToken)&key=\(Constants.YOUTUBE_API_KEY)"
        
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
            
            let dataString = String(data: data, encoding: .utf8)
            
            print("Getting dataString from api : \(String(describing: dataString))")
            
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(GetChannelResponse.self, from: data)
                print("Getting JSON from api : \(response)")
                print("total channels : \(response.items.count)")
                
                self.channels = response.items
                
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


