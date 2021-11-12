import UIKit

final class TimerView: UIView {
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let playButton: TimerButton = {
        let button = TimerButton()
        button.setTitle("Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let resetButton: TimerButton = {
        let button = TimerButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        verticalStackView.addArrangedSubview(topContainerView)
        verticalStackView.addArrangedSubview(bottomContainerView)
        topContainerView.addSubview(timeLabel)
        bottomContainerView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(resetButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: rightAnchor),

            timeLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),

            buttonStackView.leftAnchor.constraint(equalTo: bottomContainerView.leftAnchor, constant: 20),
            buttonStackView.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor, constant: -20),
            buttonStackView.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
