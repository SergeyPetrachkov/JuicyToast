//
//  JuicyToastConfig.swift
//  
//
//  Created by sergey on 04.11.2020.
//

import Foundation
import UIKit

public struct ToastMessageConfig {
  public let message: String
  public let textAlignment: NSTextAlignment
  public let textColor: UIColor
  public let font: UIFont

  public init(message: String, textAlignment: NSTextAlignment, textColor: UIColor, font: UIFont) {
    self.message = message
    self.textAlignment = textAlignment
    self.textColor = textColor
    self.font = font
  }
}

public struct ToastActionConfig {
  public let actionTitle: String
  public let textColor: UIColor
  public let font: UIFont
  public let action: () -> Void

  public init(actionTitle: String, textColor: UIColor, font: UIFont, action: @escaping () -> Void) {
    self.actionTitle = actionTitle
    self.textColor = textColor
    self.font = font
    self.action = action
  }
}

public struct JuicyToastConfig {

  public let messageConfig: ToastMessageConfig
  public let actionConfig: ToastActionConfig?
  public let backgroundColor: UIColor
  public let paddings: UIEdgeInsets
  public init(message: String,
              textAlignment: NSTextAlignment = .left,
              textColor: UIColor,
              font: UIFont,
              actionConfig: ToastActionConfig?,
              backgroundColor: UIColor,
              paddings: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)) {
    self.messageConfig = ToastMessageConfig(message: message, textAlignment: textAlignment, textColor: textColor, font: font)
    self.actionConfig = actionConfig
    self.backgroundColor = backgroundColor
    self.paddings = paddings
  }

  public init(messageConfig: ToastMessageConfig,
              actionConfig: ToastActionConfig?,
              backgroundColor: UIColor,
              paddings: UIEdgeInsets) {
    self.messageConfig = messageConfig
    self.actionConfig = actionConfig
    self.backgroundColor = backgroundColor
    self.paddings = paddings
  }
}
