import UIKit

public class JuicyToast: UIView {
  // MARK: - UI Properties
  private let textLabel: UILabel = UILabel(frame: .zero)
  private let actionButton: UIButton = UIButton(frame: .zero)
  // MARK: - Essentials
  private let config: JuicyToastConfig

  // MARK: - Initializers
  public init(config: JuicyToastConfig) {
    self.config = config
    super.init(frame: .zero)
    self.addSubview(self.textLabel)
    self.addSubview(self.actionButton)

    self.setup(with: self.config)
  }

  @available(*, unavailable, message: "Xibs and beauty are incompatible")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  #if targetEnvironment(simulator)
  deinit {
    debugPrint("\(self) deinit")
  }
  #endif

  // MARK: - Private
  private func setup(with config: JuicyToastConfig) {
    self.isUserInteractionEnabled = true
    self.textLabel.isUserInteractionEnabled = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.actionButton.translatesAutoresizingMaskIntoConstraints = false
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.accessibilityIdentifier = "Toast"
    self.textLabel.accessibilityIdentifier = "Toast message"
    self.actionButton.accessibilityIdentifier = "Toast action"
    let parStyle = NSMutableParagraphStyle()
    parStyle.alignment = config.messageConfig.textAlignment
    self.textLabel.attributedText = NSAttributedString(
      string: config.messageConfig.message,
      attributes: [
        NSAttributedString.Key.font: config.messageConfig.font,
        NSAttributedString.Key.foregroundColor: config.messageConfig.textColor,
        NSAttributedString.Key.paragraphStyle: parStyle
      ]
    )
    self.textLabel.numberOfLines = 0

    if let actionConfig = self.config.actionConfig {
      self.actionButton.setAttributedTitle(
        NSAttributedString(
          string: actionConfig.actionTitle,
          attributes: [
            NSAttributedString.Key.font: actionConfig.font,
            NSAttributedString.Key.foregroundColor: actionConfig.textColor,
          ]
        ),
        for: .normal
      )
      self.actionButton.addTarget(self, action: #selector(self.didTapAction), for: .touchUpInside)
      self.actionButton.isUserInteractionEnabled = true
      NSLayoutConstraint.activate(
        [
          self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.config.paddings.top),
          self.textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.config.paddings.left),
          self.textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.config.paddings.right),
          self.actionButton.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: self.config.paddings.bottom),
          self.actionButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.config.paddings.left),
          self.actionButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.config.paddings.right),
          self.actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.config.paddings.bottom),
        ]
      )
    } else {
      NSLayoutConstraint.activate(
        [
          self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.config.paddings.top),
          self.textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.config.paddings.left),
          self.textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.config.paddings.right),
          self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.config.paddings.bottom),
        ]
      )
    }

    self.backgroundColor = config.backgroundColor
    self.layer.cornerRadius = 8
    self.clipsToBounds = true
  }

  @objc
  private func didTapAction() {
    self.config.actionConfig?.action()
  }

  public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    // If we have a defined action handler, then make the whole toast touch act like a button tap
    if self.config.actionConfig?.action != nil {
      return self.actionButton
    } else {
      return superview?.hitTest(point, with: event)
    }
  }
}
