//
//  JuicyToastAssembly.swift
//  
//
//  Created by sergey on 04.11.2020.
//

public enum JuicyToastAssembly {
  public static func makeToast(config: JuicyToastConfig) -> JuicyToast {
    return JuicyToast(config: config)
  }
}
