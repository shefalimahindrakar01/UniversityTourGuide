//
//  MediaPlayerVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

fileprivate extension AVRoutePickerView {
    func present() {
        let routePickerButton = subviews.first(where: { $0 is UIButton }) as? UIButton
        routePickerButton?.sendActions(for: .touchUpInside)
    }
}

class MediaPlayerVC: UIViewController {
    
    @IBOutlet weak var mediaPlayerView: UIView!
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var imgStop: UIImageView!
    @IBOutlet weak var btnPreviousStop: UIButton!
    @IBOutlet weak var btnNextStop: UIButton!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var lblCurrentAudioDuration: UILabel!
    @IBOutlet weak var lblTotalAudioDuration: UILabel!
    @IBOutlet weak var btnAirplay: UIButton!
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var timeObserver: Any?
    var isPlaying = false
    
    private lazy var routePickerView: AVRoutePickerView = {
        let routePickerView = AVRoutePickerView(frame: .zero)
        routePickerView.isHidden = true
        self.view.addSubview(routePickerView)
        return routePickerView
    }()
    
    var currentAudioIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAudio(at: currentAudioIndex)
        setupRemoteTransportControls()
        setupNowPlayingInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.applyGradient(colors: [UIColor.primaryColor, UIColor.secondaryColor, UIColor.tertiaryColor])
    }
    
    func setupUI() {
        lblStopName.text = GlobalData.uonLocations[currentAudioIndex].name
        lblCurrentAudioDuration.text = "00:00"
        setupPlayer()
        setupSlider()
        setupUICustomizations()
    }
    
    func setupUICustomizations() {
        btnAirplay.setImage(UIImage(systemName: "airplayaudio"), for: .normal)
        btnAirplay.tintColor = .white
        btnPlayPause.tintColor = .white
        updatePlayPauseButtonImage()
        btnPreviousStop.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        btnPreviousStop.tintColor = .white
        btnNextStop.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        btnNextStop.tintColor = .white
        audioSlider.minimumTrackTintColor = .textColor
        audioSlider.maximumTrackTintColor = .white
    }
    
    func setupPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error.localizedDescription)")
        }
        player = AVPlayer()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func loadAudio(at index: Int) {
        guard index >= 0 && index < GlobalData.uonLocations.count else { return }
        
        currentAudioIndex = index
        let location = GlobalData.uonLocations[currentAudioIndex]
        
        let audioName = location.videoName
        if let audioURL = Bundle.main.url(forResource: audioName, withExtension: "mp3") {
            // Pause the player if it's currently playing
            player?.pause()
            
            playerItem = AVPlayerItem(url: audioURL)
            player?.replaceCurrentItem(with: playerItem)
            
            // Update UI elements
            lblStopName.text = location.name
            if let imagePath = Bundle.main.path(forResource: location.imageName, ofType: "jpg") {
                imgStop.image = UIImage(contentsOfFile: imagePath)
            } else {
                imgStop.image = UIImage() // Default image if not found
            }
            
            let duration = CMTimeGetSeconds(playerItem!.asset.duration)
            audioSlider.maximumValue = Float(duration)
            lblTotalAudioDuration.text = formatTime(seconds: Int(duration))
            
            // Reset slider and current time label
            audioSlider.value = 0
            lblCurrentAudioDuration.text = "00:00"
            
            // Remove time observer from previous player item
            if let observer = timeObserver {
                player?.removeTimeObserver(observer)
                timeObserver = nil
            }
            
            // Add observer for time updates
            timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] time in
                guard let self = self else { return }
                let currentTime = CMTimeGetSeconds(time)
                self.audioSlider.value = Float(currentTime)
                self.lblCurrentAudioDuration.text = self.formatTime(seconds: Int(currentTime))
                self.updateNowPlayingInfo()
            }
        }
    }
    
    func setupSlider() {
        audioSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        updatePlayPauseButtonImage()
        updateNowPlayingInfo()
    }
    
    func updatePlayPauseButtonImage() {
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        let image = UIImage(systemName: imageName)
        btnPlayPause.setImage(image, for: .normal)
    }
    
    @IBAction func nextStopAction(_ sender: UIButton) {
        if currentAudioIndex < GlobalData.uonLocations.count - 1 {
            currentAudioIndex += 1
        } else {
            currentAudioIndex = 0 // Loop back to the first audio
        }
        loadAudio(at: currentAudioIndex)
        isPlaying = false // Reset play state
        updatePlayPauseButtonImage()
    }
    
    @IBAction func previousStopAction(_ sender: UIButton) {
        if currentAudioIndex > 0 {
            currentAudioIndex -= 1
        } else {
            currentAudioIndex = GlobalData.uonLocations.count - 1 // Loop back to the last audio
        }
        loadAudio(at: currentAudioIndex)
        isPlaying = false // Reset play state
        updatePlayPauseButtonImage()
    }
    
    @objc func playerDidFinishPlaying() {
        print("Audio playback ended")
        isPlaying = false
        updatePlayPauseButtonImage()
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        let value = CMTimeMake(value: Int64(slider.value), timescale: 1)
        player?.seek(to: value)
        lblCurrentAudioDuration.text = formatTime(seconds: Int(slider.value))
        updateNowPlayingInfo()
    }
    
    func formatTime(seconds: Int) -> String {
        let minutes = (seconds / 60) % 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func airplayAction(_ sender: UIButton) {
        routePickerView.present()
    }
    
    deinit {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
        NotificationCenter.default.removeObserver(self)
    }
}

extension MediaPlayerVC {
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            
            self.player?.play()
            self.isPlaying = true
            self.updatePlayPauseButtonImage()
            self.updateNowPlayingInfo()
            
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            
            self.player?.pause()
            self.isPlaying = false
            self.updatePlayPauseButtonImage()
            self.updateNowPlayingInfo()
            
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            
            self.nextStopAction(self.btnNextStop)
            self.updateNowPlayingInfo()
            
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            
            self.previousStopAction(self.btnPreviousStop)
            self.updateNowPlayingInfo()
            
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            guard let event = event as? MPChangePlaybackPositionCommandEvent else { return .commandFailed }
            
            let time = CMTime(seconds: event.positionTime, preferredTimescale: 1)
            self.player?.seek(to: time)
            self.updateNowPlayingInfo()
            
            return .success
        }
    }
    
    func setupNowPlayingInfo() {
        guard let player = player, let playerItem = playerItem else { return }
        
        var nowPlayingInfo = [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = lblStopName.text
        // Set other metadata as needed: artist, album, duration, etc.
        
        // Set artwork
        if let imagePath = Bundle.main.path(forResource: GlobalData.uonLocations[currentAudioIndex].imageName, ofType: "jpg") {
            let image = UIImage(contentsOfFile: imagePath)
            let artwork = MPMediaItemArtwork(boundsSize: image?.size ?? .zero) { _ in return image ?? UIImage() }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func updateNowPlayingInfo() {
        guard let player = player, let playerItem = playerItem else { return }
        
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = CMTimeGetSeconds(playerItem.duration)
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        nowPlayingInfo[MPMediaItemPropertyTitle] = lblStopName.text
        // Update other metadata as needed
        
        // Update artwork
        if let imagePath = Bundle.main.path(forResource: GlobalData.uonLocations[currentAudioIndex].imageName, ofType: "jpg") {
            let image = UIImage(contentsOfFile: imagePath)
            let artwork = MPMediaItemArtwork(boundsSize: image?.size ?? .zero) { _ in return image ?? UIImage() }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
