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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        view.addSubview(square)
        square.backgroundColor = .systemBlue
        square.layer.cornerRadius = 6
        
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderEnded), for: [.touchCancel, .touchUpInside])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let leftMargin = view.layoutMargins.left
        let rightMargin = view.layoutMargins.right
        slider.frame = CGRect(x: leftMargin, y: 300, width: view.frame.width - rightMargin - leftMargin, height: 24)
        square.frame = CGRect(x: leftMargin, y: 100, width: 100, height: 100)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let leftMargin = view.layoutMargins.left
//        let rightMargin = view.layoutMargins.right
//        slider.frame = CGRect(x: leftMargin, y: 300, width: view.frame.width - rightMargin - leftMargin, height: 24)
//        square.frame = CGRect(x: leftMargin, y: 100, width: 100, height: 100)
//    }

    @objc
    func sliderAction(_ slider: UISlider) {
        print("sliderValue = \(slider.value)")
        let left = self.view.layoutMargins.left
        let right = self.view.layoutMargins.right

//        self.square.frame.origin.x =
//        self.view.layoutMargins.left
//        + (self.view.frame.width - self.square.frame.width - left - right)
//        * CGFloat(slider.value)
        
//        self.square.transform = CGAffineTransform(rotationAngle: (.pi)*CGFloat(slider.value))
//        self.square.transform = CGAffineTransform(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
        
        var t = CGAffineTransform.identity
        t = t.translatedBy(
            x: self.view.layoutMargins.left
            + (self.view.frame.width - self.square.frame.width - left - right)
            * CGFloat(slider.value),
            y: 0
        )
        t = t.rotated(by: CGFloat(slider.value) * CGFloat.pi / 2)
//        t = t.scaledBy(x: 1, y: 1)
        self.square.transform = t

//        UIView.animate(withDuration: 0) {
//            self.view.layoutIfNeeded()
//        }
    }
    
    @objc
    func sliderEnded(_ slider: UISlider) {
        guard slider.value != 0 else { return }
        
        UIView.animate(withDuration: 0.8) {
            slider.value = 1
            self.square.frame.origin.x = self.view.frame.width - self.view.layoutMargins.right - self.square.frame.width
            self.view.layoutIfNeeded()
        }
    }

}

