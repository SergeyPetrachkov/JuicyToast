//
//  ToastPosition.swift
//  
//
//  Created by sergey on 04.11.2020.
//

import UIKit

/// Toast can be centered by X axis and be positioned either centered by Y or moved to the bottom or top layout guides with additional offsets.
public enum ToastPosition {
  case middle
  case bottom(CGFloat)
  case top(CGFloat)
}
