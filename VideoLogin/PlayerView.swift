//
//  PlayerView.swift
//  VideoLogin
//
//  Created by rezatec on 30/06/2021.
//

import UIKit
import AVKit

class PlayerView: UIView {
    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    public var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
