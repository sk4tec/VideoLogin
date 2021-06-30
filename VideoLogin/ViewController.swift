//
//  ViewController.swift
//  VideoLogin
//
//  Created by rezatec on 28/06/2021.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var playerLayerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let videoURL = createLocalUrl(for: "waves", ofType: "mp4") else {
            return
        }
        
        playerLayerView.player = AVPlayer(url: videoURL)
        playerLayerView.player?.play()
        playerLayerView.playerLayer.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerLayerView.player?.currentItem, queue: .main) { [weak self] _ in
            self!.playerLayerView.player!.seek(to: CMTime.zero)
            self!.playerLayerView.player!.play()
        }
    }
    
    func createLocalUrl(for filename: String, ofType: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(filename).\(ofType)")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard let video = NSDataAsset(name: filename)  else { return nil }
            fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
            return url
        }
        
        return url
    }
}

