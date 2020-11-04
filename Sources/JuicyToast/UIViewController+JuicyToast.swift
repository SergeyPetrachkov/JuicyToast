//
//  UIViewController+JuicyToast.swift
//  
//
//  Created by sergey on 04.11.2020.
//

import UIKit

public extension UIViewController {
  func showToast(_ toast: JuicyToast, duration: Double, position: ToastPosition = .middle) {
    self.view.addSubview(toast)
    self.view.bringSubviewToFront(toast)
    toast.translatesAutoresizingMaskIntoConstraints = false

    toast.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor).isActive = true
    toast.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    toast.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
    toast.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    switch position {
    case .middle:
      toast.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor).isActive = true
    case .bottom(let bottomOffset):
      toast.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomOffset).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, constant: -bottomOffset).isActive = true
    case .top(let topOffset):
      toast.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topOffset).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, constant: -topOffset).isActive = true
    }

    toast.setNeedsLayout()
    UIView.animateKeyframes(
      withDuration: duration,
      delay: 0.1,
      options: .calculationModeLinear,
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
          toast.alpha = 1
          toast.isOpaque = true
          toast.isUserInteractionEnabled = true
        })
        UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
          toast.alpha = 0
        })
      },
      completion: { _ in
        toast.removeFromSuperview()
      }
    )
  }
}
