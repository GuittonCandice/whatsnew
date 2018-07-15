//
//  VideoViewController.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit
import YouTubePlayer
class VideoViewController: UIViewController, YouTubePlayerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var favoriteButtonView: UIBarButtonItem!
    @IBOutlet weak var youtubeVideoPlayer: YouTubePlayerView!
    @IBOutlet weak var playerLoader: UIActivityIndicatorView!
    @IBOutlet weak var contentLoader: UIActivityIndicatorView!
    @IBOutlet weak var contentLoadingView: UIView!
    @IBOutlet weak var youtubePlayerLoadingView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var thumbUpLabel: UILabel!
    @IBOutlet weak var thumbDownLabel: UILabel!
    
    @IBOutlet weak var viewCountLabel: UILabel!
    var videoId: String?
    var userToken: String?
    var smallUrl: String?
    var currentFavorite: VideoFavorite?
    
    override func viewDidLoad() {
        guard let videoId = videoId else {return}
        
        self.currentFavorite = VideoFavorite(videoId: self.videoId!,
                                             url: nil,
                                             smallUrl: nil,
                                             title: nil,
                                             description: nil)
        if FileStorage.fileExists(Constants.FAVORITES_ARRAY_FILE, in: FileStorage.Directory.documents) {
            let favoritessFromDisk = FileStorage.retrieve(Constants.FAVORITES_ARRAY_FILE, from: .documents, as: [VideoFavorite].self)
            
            if favoritessFromDisk.contains(currentFavorite!) {
                favoriteButtonView.image = UIImage(named: "heartEnabled")
                favoriteButtonView.tintColor = UIColor.red
            } else {
                favoriteButtonView.image = UIImage(named: "heartDisabled")
            }
        } else {
            favoriteButtonView.image = UIImage(named: "heartDisabled")
        }
        
        
       
        
        playerLoader.startAnimating()
        contentLoader.startAnimating()
        
        youtubeVideoPlayer.loadVideoID(videoId)
        youtubeVideoPlayer.delegate = self
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        showPlayer()
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
    
    @IBAction func onFavoriteButtonClick(_ sender: UIBarButtonItem) {
        
        guard let currentFavorite = currentFavorite else {return}
        
        if FileStorage.fileExists(Constants.FAVORITES_ARRAY_FILE, in: FileStorage.Directory.documents) {
            var favoritesFromDisk = FileStorage.retrieve(Constants.FAVORITES_ARRAY_FILE, from: .documents, as: [VideoFavorite].self)
            
            if favoritesFromDisk.contains(currentFavorite) {
                
                if let index  = favoritesFromDisk.index(of: currentFavorite) {
                    
                    print("Favorite Already existing, we remove it")
                    favoritesFromDisk.remove(at: index)
                    favoriteButtonView.image = UIImage(named: "heartDisabled")
                }
                
                
            } else {
                print("Adding to favorite \(currentFavorite)")
                favoritesFromDisk.append(currentFavorite)
                favoriteButtonView.image = UIImage(named: "heartEnabled")
                favoriteButtonView.tintColor = UIColor.red
            }
            
            FileStorage.store(favoritesFromDisk, to: .documents, as: Constants.FAVORITES_ARRAY_FILE)
        } else {
            favoriteButtonView.image = UIImage(named: "heartEnabled")
            favoriteButtonView.tintColor = UIColor.red
            let newList = [currentFavorite]
            FileStorage.store(newList, to: .documents, as: Constants.FAVORITES_ARRAY_FILE)
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
        
        let urlString = "\(Constants.VIDEO_URL)?id=\(videoId)&part=snippet,statistics,contentDetails&access_token=\(userToken)&key=\(Constants.YOUTUBE_API_KEY)"
        
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
                let response = try decoder.decode(GetVideoResponse.self, from: data)
                print("Getting JSON from api : \(response)")
                
                DispatchQueue.main.async{
                    self.showContent(response: response)
                }
               
                
            } catch let errorJson {
                print(errorJson)
                return
            }
            
            }.resume()
        
    }
    
    func showPlayer() {
        playerLoader.stopAnimating()
        youtubePlayerLoadingView.isHidden = true
        youtubeVideoPlayer.isHidden = false
    }
    
    func showContent(response: GetVideoResponse) {
        contentLoader.stopAnimating()
        contentLoadingView.isHidden = true
        
        let video = response.items[0]
        
        self.currentFavorite = VideoFavorite(videoId: self.videoId!,
                                             url: video.snippet.thumbnails.medium.url,
                                             smallUrl: self.smallUrl,
                                             title: video.snippet.title,
                                             description: video.snippet.description)
        
        titleLabel.text = video.snippet.title
        viewCountLabel.text = video.statistics.viewCount
        thumbUpLabel.text = video.statistics.likeCount
        thumbDownLabel.text = video.statistics.dislikeCount
        commentCountLabel.text = video.statistics.commentCount
        descriptionLabel.text = video.snippet.description
    }
    
}
