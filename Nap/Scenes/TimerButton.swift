import UIKit

final class TimerButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .secondaryLabel : .tertiaryLabel
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        alpha = 0.8
        titleLabel?.font = .systemFont(ofSize: 40)
        layer.cornerRadius = 20
        backgroundColor = .tertiaryLabel
        setTitleColor(.label, for: .normal)
        setTitleColor(.gray, for: .disabled)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
