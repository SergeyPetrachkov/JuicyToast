//
//  JuicyToastManager.swift
//  
//
//  Created by sergey on 04.11.2020.
//

import UIKit

public final class JuicyToastManager {
  public static let shared = JuicyToastManager()

  private(set) public var window: UIWindow?
  private(set) public weak var currentToast: JuicyToast?

  init(window: UIWindow? = UIApplication.shared.keyWindow) {
    self.window = window
  }

  public func showToast(_ toast: JuicyToast, duration: Double, position: ToastPosition = .middle) {
    guard let window = self.window else {
      assertionFailure("No key window found")
      return
    }
    guard self.currentToast == nil else {
      assertionFailure("There is already a toast presented on screen ")
      return
    }
    window.addSubview(toast)
    window.bringSubviewToFront(toast)
    self.currentToast = toast
    toast.translatesAutoresizingMaskIntoConstraints = false

    toast.widthAnchor.constraint(lessThanOrEqualTo: window.widthAnchor).isActive = true
    toast.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    toast.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
    toast.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
    switch position {
    case .middle:
      toast.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: window.heightAnchor).isActive = true
    case .bottom(let bottomOffset):
      toast.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -bottomOffset).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: window.heightAnchor, constant: -bottomOffset).isActive = true
    case .top(let topOffset):
      toast.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: topOffset).isActive = true
      toast.heightAnchor.constraint(lessThanOrEqualTo: window.heightAnchor, constant: -topOffset).isActive = true
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
          print("added: ", toast)
        })
        UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
          toast.alpha = 0
        })
      },
      completion: { _ in
        toast.removeFromSuperview()
        self.currentToast = nil
        print("removed: ", toast.frame)
      }
    )
  }
}
