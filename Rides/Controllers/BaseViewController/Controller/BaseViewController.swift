//
//  BaseViewController.swift
//  FantomLED
//
//  Created by Surjeet Singh on 01/06/18.
//  Copyright © 2018 Surjeet Singh. All rights reserved.
//

import UIKit
import AVFoundation


protocol BaseDataSources {
    func setUpClosures()
    func setUpView()
}

class BaseViewController: UIViewController {
  

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadVideo()
        self.hideNavigationBar(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = false
    }
    
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
   
    final func initBaseModel() {}
    /// This method would execute when user switches from dark mode to light or Vice-versa.
    /// You can use this method in your view controller as well if you have different checks according to your requirments.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    private func loadVideo() {

        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

        let path = Bundle.main.path(forResource: "rides", ofType:"mp4")

        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        playerLayer = AVPlayerLayer(player: player)

        playerLayer?.frame = self.view.frame
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer?.zPosition = -1

        self.view.layer.addSublayer(playerLayer!)

        player?.seek(to: CMTime.zero)
        player?.play()
    }
}

extension BaseViewController {
    
    private func _storyboard() ->  UIStoryboard? {
        return UIStoryboard(name: Storyboards.main, bundle:nil)
    }
    

    
    func mainStoryboardController(withIdentifier identifier: String) -> UIViewController {
        if let viewC = _storyboard()?.instantiateViewController(withIdentifier: identifier) {
            return viewC
        }
        return UIViewController()
    }
    
}
