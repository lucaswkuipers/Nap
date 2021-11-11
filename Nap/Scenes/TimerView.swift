import UIKit

final class TimerView: UIView {
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        return stackView
    }()

    let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.text = "23:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewHierarchy() {
        addSubview(verticalStackView)
        topContainerView.addSubview(timeLabel)
        verticalStackView.addArrangedSubview(topContainerView)
        verticalStackView.addArrangedSubview(bottomContainerView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: rightAnchor),

            timeLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor)
        ])
    }
}
