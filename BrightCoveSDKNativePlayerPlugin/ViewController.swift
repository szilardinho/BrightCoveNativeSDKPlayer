//
//  ViewController.swift
//  BrightCoveSDKNativePlayerPlugin
//
//  Created by Szi Gabor on 6/14/17.
//  Copyright © 2017 Szi. All rights reserved.
//

import UIKit

let kViewControllerAccountID = "5470155812001"

let kViewControllerPlaybackServicePolicyKey = "BCpkADawqM14-qGfk593efh2m22h5CEAOSvgMdpEQN4I6lriwOCLTyHmWuj8zBFS--rFViezYStR01aVOANg-9w8NDu8ggl3yELp6MfQNxPLgt_ZhGuQh2ivBFfmDjldZxIWIXDH2kINmqar"

let kViewControllerVideoID = "5471123527001"


class ViewController: UIViewController, BCOVPlaybackControllerDelegate,BCOVPUIPlayerViewDelegate {
    
    let playbackController: BCOVPlaybackController
    let playbackService = BCOVPlaybackService(accountId: kViewControllerAccountID, policyKey: kViewControllerPlaybackServicePolicyKey)
    
    
    
    @IBOutlet weak var videoContainer: UIView!
    
    
    
    required init?(coder aDecoder:NSCoder) {
        let manager = BCOVPlayerSDKManager.shared()!
        playbackController = manager.createPlaybackController()
        
        super.init(coder: aDecoder)
        
      //  playbackController.analytics.account = kViewControllerAccountID
        
        playbackController.delegate = self
        playbackController.isAutoAdvance = true
        playbackController.isAutoPlay = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create and set options
        let options = BCOVPUIPlayerViewOptions()
        options.presentingViewController = self
        
        
        //Create and configure Control View
        let controlsView = BCOVPUIBasicControlView.withVODLayout()
        let playerView = BCOVPUIPlayerView.init(playbackController: playbackController, options: options, controlsView: controlsView)!
        
        playerView.delegate = self
        playerView.frame = videoContainer.bounds
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        videoContainer.addSubview(playerView)
        
//      requestContentFromPlaybackService()
        
    }
    
    func requestContentFromPlaybackService() {
     
        playbackService?.findVideo(withVideoID: kViewControllerVideoID, parameters: nil) {
            
            (video:BCOVVideo?, dict: [AnyHashable:Any]?, error: Error?) in
            if let v = video {
                self.playbackController.setVideos([v] as NSFastEnumeration!)
            
                
            } else {
                print("View Controller Debug - Error retrieving videos: \(error.debugDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

