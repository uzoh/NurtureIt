//
//  CreateScheduleViewController.swift
//  Nurture
//
//  Created by Uzoh Okwara on 4/28/21.
//

import UIKit
import Lottie

class CreateScheduleViewController: UIViewController {

    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("alarmClock")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }

}
