//
//  ViewController.swift
//  Lottie-Progress-Example
//
//  Created by William Boles on 06/09/2018.
//  Copyright © 2018 Boles. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animatedControl: LOTAnimatedControl!

    private var animationTimer: Timer?
    private var completedProgress = 0.0
    
    // MARK: - ViewLifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        animatedControl.animationView.setAnimation(named: "ProgressAnimation")
    }
    
    // MARK: - ButtonActions
    
    @IBAction func startAnimationButtonPressed(_ sender: Any) {
        animationTimer?.invalidate()
        animatedControl.animationView.stop()
        animatedControl.animationView.animationProgress = 0
        completedProgress = 0
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.animateProgress()
        })
    }
    
    // MARK: - Progress
    
    func animateProgress() {
        guard !completedProgress.isAlmostEqual(to: 1) else {
            animatedControl.animationView.animationProgress = 1
            animationTimer?.invalidate()
            return
        }
        
        let fromProgress = completedProgress
        let toProgress = completedProgress + 0.1
        completedProgress = toProgress
        
        animatedControl.animationView.animationProgress = CGFloat(fromProgress) //ensure that animation starts at expected progress value
        animatedControl.animationView.play(fromProgress: CGFloat(fromProgress), toProgress: CGFloat(toProgress), withCompletion: nil)
    }
}

extension Double {
    
    // comparing two doubles or floats that are not created with exactly the same number (and in exactly the same way) will result
    // in those numbers actaully not being the same. In this method is check that the two doubles are "almost" same and if they are
    // we settle for that
    // https://stackoverflow.com/questions/49377362/how-two-double-values-equality-always-coming-false-even-if-the-values-are-equal
    func isAlmostEqual(to other: Double) -> Bool {
        return fabs(self - other) < Double.ulpOfOne
    }
}
