# JuicyToast

Show configurable toast messages with optional action.

## Usage 

### Preferred way

```Swift
import JuicyToast
/// ...
let toastConfig = JuicyToastConfig(
    messageConfig: ToastMessageConfig(
      message: "Your video has been saved to the gallery!",
      textAlignment: .center,
      textColor: .white,
      font: UIFont.systemFont(ofSize: 16)
    ),
    actionConfig: ToastActionConfig(
      actionTitle: "Share the clip",
      textColor: .blue,
      font: UIFont.systemFont(ofSize: 15),
      action: { [weak self] in
        guard let self = self else {
          return
        }
        print("Tapped action. ")
      }
    ),
    backgroundColor: .black,
    paddings: .init(top: 10, left: 10, bottom: 10, right: 10)
)
let toast = JuicyToastAssembly.makeToast(config: toastConfig)
JuicyToastManager.shared.showToast(toast, duration: 5, position: .middle)
```

### Alternative ways

Beware, it you want the toast to show above uitableviewcontroller, then you definitely need to use JuicyToastManager, so the toast adds to the window and not gets scrolled
```Swift
import UIKit
import JuicyToast

class MyController: UIViewController {
  func reactToSomeEvent() {
    let toastConfig = JuicyToastConfig(
      messageConfig: ToastMessageConfig(
        message: "Your video has been saved to the gallery!",
        textAlignment: .center,
        textColor: .white,
        font: UIFont.systemFont(ofSize: 16)
      ),
      actionConfig: ToastActionConfig(
        actionTitle: "Share the clip",
        textColor: .blue,
        font: UIFont.systemFont(ofSize: 15),
        action: { [weak self] in
          guard let self = self else {
            return
          }
          print("Tapped action. ")
        }
      ),
      backgroundColor: .black,
      paddings: .init(top: 10, left: 10, bottom: 10, right: 10)
    )
    let toast = JuicyToastAssembly.makeToast(config: toastConfig)
    self.showToast(toast, duration: 5, position: .middle)
  }
}
```
