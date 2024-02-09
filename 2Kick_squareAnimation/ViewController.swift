//
//  ViewController.swift
//  2Kick_squareAnimation
//
//  Created by Нечаев Михаил on 07.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider()
    let square = UIView()

    var runningAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        view.addSubview(square)
        square.backgroundColor = .systemBlue
        square.layer.cornerRadius = 6
        
        slider.addTarget(self, action: #selector(sliderStart), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderEnded), for: [.touchCancel, .touchUpInside, .touchDragExit])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let leftMargin = view.layoutMargins.left
        let rightMargin = view.layoutMargins.right
        square.frame = CGRect(x: leftMargin, y: 150, width: 100, height: 100)
        slider.frame = CGRect(x: leftMargin, y: 300, width: view.frame.width - rightMargin - leftMargin, height: 24)
    }
    
    @objc
    func sliderStart(_ slider: UISlider) {
        startInteractiveTransition(fromZero: slider.value == 0)
    }
    
    @objc
    func sliderAction(_ slider: UISlider) {
        updateInteractiveTransition(value: CGFloat(slider.value))
    }
    
    @objc
    func sliderEnded(_ slider: UISlider) {
        continueInteractiveTransition(value: CGFloat(slider.value))
    }
    
    private func startInteractiveTransition(fromZero: Bool) {
        runningAnimator = nil
        runningAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .linear, animations: {
            let left = self.view.layoutMargins.left
            let right = self.view.layoutMargins.right
            
            
            var t = CGAffineTransform.identity
            t = t.translatedBy(
                x: (self.view.frame.width - self.square.frame.width - left),
                y: -15
            )
            t = t.rotated(by: CGFloat.pi / 2)
            let scale = 1.5
            t = t.scaledBy(x: scale, y: scale)
            self.square.transform = t
        })
        runningAnimator?.pauseAnimation()
    }
    
    private func updateInteractiveTransition(value: CGFloat) {
        runningAnimator?.fractionComplete = value
    }
    
    private func continueInteractiveTransition(value: CGFloat) {
        if value == 0 {
//            runningAnimator?.isReversed = true
            runningAnimator?.stopAnimation(true)
            return
        }
        runningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
        
        runningAnimator?.addAnimations {
            self.slider.value = 1
            self.view.layoutIfNeeded()
        }
    }

    /*
    @objc
    func sliderAction(_ slider: UISlider) {
        let left = self.view.layoutMargins.left
        let right = self.view.layoutMargins.right
        
        
        var t = CGAffineTransform.identity
        t = t.translatedBy(
            x: (self.view.frame.width - self.square.frame.width - left)
            * CGFloat(slider.value),
            y: -15 * CGFloat(slider.value)
        )
        t = t.rotated(by: CGFloat(slider.value) * CGFloat.pi / 2)
        let scale = CGFloat(1 + 0.5 * slider.value)
        t = t.scaledBy(x: scale, y: scale)
        self.square.transform = t

//        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
//        }
    }
    
    @objc
    func sliderEnded(_ slider: UISlider) {
        guard slider.value != 0 else { return }
        
        
        let left = self.view.layoutMargins.left
        let right = self.view.layoutMargins.right
        
        UIView.animate(withDuration: 0.8) {
            
            var t = CGAffineTransform.identity
            t = t.translatedBy(
                x: self.view.frame.width - self.square.frame.width - left,
                y: -15
            )
            t = t.rotated(by: CGFloat.pi / 2)
            let scale = 1.5
            t = t.scaledBy(x: scale, y: scale)
            self.square.transform = t
            
            slider.value = 1
            self.view.layoutIfNeeded()
        }
    }
*/
}

