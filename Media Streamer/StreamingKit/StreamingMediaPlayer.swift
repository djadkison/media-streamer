//
//  StreamingMediaPlayer.swift
//  StreamingKit
//
//  Created by Dustin Adkison on 7/31/22.
//

import AVKit
import AVFoundation

open class StreamingMediaPlayer {
    
    // MARK: - UI
    private let playerViewController = AVPlayerViewController()
    private lazy var playerView: UIView = {
        guard let view = playerViewController.view else { return UIView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    private let avPlayer = AVPlayer()
    
    // MARK: - Lifecycle
    public init() {}
    
    // MARK: - Public Interface
    public func add(to view: UIView) {
        view.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func play(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)
        playerViewController.player = avPlayer
        playerViewController.player?.play()
    }
    
    public func pause() {
        playerViewController.player?.pause()
    }
    
}
