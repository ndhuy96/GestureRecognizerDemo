//
//  ViewController.swift
//  GestureRecognizerDemo
//
//  Created by mac on 6/6/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    fileprivate var viewOriginalPosition: CGPoint!
    fileprivate var currentRadius: CGFloat = 0.0
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var pinchGesture: UIPinchGestureRecognizer!
    fileprivate var rotationGesture: UIRotationGestureRecognizer!
    fileprivate var swipeUpGesture: UISwipeGestureRecognizer!
    fileprivate var swipeDownGesture: UISwipeGestureRecognizer!
    fileprivate var panGesture: UIPanGestureRecognizer!
    fileprivate var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        viewOriginalPosition = imageView.frame.origin
        setupGestureRecognizer()
        setupCustomGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        //TapGestureRecognizer
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        
        //PinchGestureRecognizer
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGestureRecognizer))
        
        //RotationGestureRecognizer
        rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGestureRecognizer))
        
        //SwipeGestureRecognizer
        swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureRecognizer))
        swipeUpGesture.direction = .up
        swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureRecognizer))
        swipeDownGesture.direction = .down
        
        //PanGestureRecognizer
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer))
        panGesture.minimumNumberOfTouches = 1
        
        //ScreenEdgePanGestureRecognizer
        screenEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePanGestureRecognizer))
        screenEdgePanGesture.edges = .left
        
        //LongPressGestureRecognizer
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGestureRecognizer))
        
        for gesture in [tapGesture, pinchGesture, rotationGesture, swipeUpGesture, swipeDownGesture, panGesture, longPressGesture] {
            guard let gesture = gesture else { return }
            imageView.addGestureRecognizer(gesture)
            gesture.delegate = self
        }
        
        view.addGestureRecognizer(screenEdgePanGesture)
    }
    
    func setupCustomGestureRecognizer() {
        let tickleGesture = TickleGestureRecognizer(target: self,
                                                    action:#selector(handleTickle))
        tickleGesture.delegate = self
        view.addGestureRecognizer(tickleGesture)
    }
}

extension MainViewController {
    @objc
    func handleTickle(_ gesture: TickleGestureRecognizer) {
        print("Custom")
    }
 
    @objc
    fileprivate func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        if imageView.backgroundColor == .darkGray {
            imageView.backgroundColor = .blue
        } else {
            imageView.backgroundColor = .darkGray
        }
    }
    
    @objc
    fileprivate func handlePinchGestureRecognizer(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        if sender.state == .began || sender.state == .changed {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
        }
    }
    
    @objc
    fileprivate func handleRotationGestureRecognizer(_ sender: UIRotationGestureRecognizer) {
        guard let view = sender.view else { return }
        if sender.state == .began || sender.state == .changed {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @objc
    fileprivate func handleSwipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            print("Swipe Up")
            imageView.backgroundColor = .yellow
        case .down:
            print("Swipe Down")
            imageView.backgroundColor = .darkGray
        default:
            break
        }
    }
    
    @objc
    fileprivate func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: view, sender: sender)
        case .ended:
            returnViewToOriginal(view: view)
        default:
            break
        }
    }
    
    fileprivate func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(.zero, in: view)
    }
    
    fileprivate func returnViewToOriginal(view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.frame.origin = self.viewOriginalPosition
        }
    }
    
    @objc
    func handleScreenEdgePanGestureRecognizer(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            if self.currentRadius==360.0 {
                self.currentRadius=0.0
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                self.currentRadius += 90.0
                self.imageView.transform = CGAffineTransform(rotationAngle: (self.currentRadius * CGFloat(Double.pi)) / 180.0)
            })
        }
    }
    
    @objc
    func handleLongPressGestureRecognizer(_ sender: UILongPressGestureRecognizer) {
        print("Long press gesture is recognized")
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let name = gestureRecognizer.name else { return false }
        print(name)
        return true
    }
    
    //Delaying the recognition of a pan gesture until after a swipe fails
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture &&
            otherGestureRecognizer == self.swipeUpGesture || otherGestureRecognizer == self.swipeDownGesture {
            return true
        }
        return false
    }
}
