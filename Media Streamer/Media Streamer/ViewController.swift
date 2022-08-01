//
//  ViewController.swift
//  Media Streamer
//
//  Created by Dustin Adkison on 7/31/22.
//

import UIKit
import StreamingKit

class ViewController: UIViewController {
    
    // MARK: - UI
    let tableView = UITableView()
    
    let urlTextField = UITextField()
    let actionsStackView = UIStackView()
    let playButton = UIButton()
    let pauseButton = UIButton()
    let clearButton = UIButton()
    let mediaPlayerView = UIView()
    
    // MARK: - Properties
    private let mediaPlayer = StreamingMediaPlayer()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Media Streamer"
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        view.backgroundColor = .white
        setupTableView()
        setupUrlTextField()
        setupActionsStackView()
        setupMediaPlayerView()
        
        layout()
    }
    
    /// Set table view properties
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    /// Set url text field properties
    private func setupUrlTextField() {
        view.addSubview(urlTextField)
        urlTextField.placeholder = "Enter url here"
    }
    
    /// Set actions stack view properties
    private func setupActionsStackView() {
        view.addSubview(actionsStackView)
        actionsStackView.axis = .horizontal
        actionsStackView.alignment = .center
        actionsStackView.distribution = .fillEqually
        actionsStackView.spacing = 16
        
        // Add buttons to stack view
        actionsStackView.addArrangedSubview(playButton)
        actionsStackView.addArrangedSubview(pauseButton)
        actionsStackView.addArrangedSubview(clearButton)
        
        // Set play button properties
        playButton.setTitle("Play", for: .normal)
        playButton.backgroundColor = .systemGreen
        playButton.setTitleColor(.white, for: .normal)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        
        // Set pause button properties
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.backgroundColor = .systemYellow
        pauseButton.setTitleColor(.white, for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
        
        // Set clear button properties
        clearButton.setTitle("Clear", for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
    }
    
    /// Set media player properties
    private func setupMediaPlayerView() {
        view.addSubview(mediaPlayerView)
        mediaPlayerView.backgroundColor = .black
        
        mediaPlayer.add(to: mediaPlayerView)
    }
    
    // MARK: - Layout
    /// Define constraints and layout for views.
    private func layout() {
        
        additionalSafeAreaInsets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        mediaPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            urlTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            urlTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            urlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            actionsStackView.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 16),
            actionsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            actionsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            mediaPlayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mediaPlayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mediaPlayerView.heightAnchor.constraint(equalTo: mediaPlayerView.widthAnchor),
            mediaPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Action Handlers
    @objc private func playAction() {
        guard let text = urlTextField.text, let url = URL(string: text) else {
            // TODO: present error
            print("Error parsing URL")
            return
        }
        mediaPlayer.play(url: url)
    }
    
    @objc private func pauseAction() {
        mediaPlayer.pause()
    }
    
    @objc private func clearAction() {
        urlTextField.text = nil
        mediaPlayer.pause()
    }

}

