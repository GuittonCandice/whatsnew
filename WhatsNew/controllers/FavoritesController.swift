//
//  ViewController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 03/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit

class FavoritesController: UITableViewController {
    
    
    var videosFavorites: [VideoFavorite]?
    var userToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = videosFavorites?.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoFavoriteCell", for: indexPath) as! ChannelActivityCell
        
        guard let videos = videosFavorites else { return cell}
        
        cell.ibTitleLabel.text = videos[indexPath.row].title
        cell.descriptionLabel.text = videos[indexPath.row].description
        
        if let mediumUrl = videos[indexPath.row].url {
            let mediumUrlResource = URL(string: mediumUrl)
            cell.ibImageView.kf.setImage(with: mediumUrlResource)
        }
        
        if let smallUrl = videos[indexPath.row].smallUrl {
            let smallUrlResource = URL(string: smallUrl)
            cell.avatarImageView.kf.setImage(with: smallUrlResource)
            
            // Circular imageView
            cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height / 2
            cell.avatarImageView.layer.masksToBounds = false
            cell.avatarImageView.clipsToBounds = true
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        if let userToken:String = defaults.string(forKey: Constants.USER_TOKEN_KEY)  {
            
            print("userToken \(userToken)")
            self.userToken = userToken
            
            loadFavorites()
            
        } else {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
        
    }
    
    @IBAction func onTrashClicked(_ sender: UIBarButtonItem) {
        
        FileStorage.clear(FileStorage.Directory.documents)
        self.videosFavorites = []
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "showVideoFromFavorite" == segue.identifier {
            let destinationController = segue.destination as!VideoViewController
            let cell = sender as! ChannelActivityCell
            let indexPath = tableView.indexPath(for: cell)
            
            if videosFavorites != nil {
                let item = videosFavorites?[(indexPath?.row)!]
                destinationController.videoId = item?.videoId
            }
            
        }
        
    }
    
    func loginAgain() {
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    func loadFavorites() {
        
        if FileStorage.fileExists(Constants.FAVORITES_ARRAY_FILE, in: FileStorage.Directory.documents) {
            
            let favoritesFromDisk = FileStorage.retrieve(Constants.FAVORITES_ARRAY_FILE, from: .documents, as: [VideoFavorite].self)
            self.videosFavorites = favoritesFromDisk
            self.tableView.reloadData()
        }
        
    }
}



