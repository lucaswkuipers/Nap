import UIKit

struct CountdownTime {
    let minutes: Int
    let seconds: Int
}

final class Countdown {
    var secondsRemaining: Int
    var startingTime: Int

    init(startingAt time: CountdownTime) {
        secondsRemaining = time.minutes * 60 + time.seconds
        startingTime = secondsRemaining
    }

    func updateTime() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            secondsRemaining = 0
        }
    }

    func resetTime() {
        secondsRemaining = startingTime
    }

    func getFormattedTime() -> String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        return formattedTime
    }
}

final class TimerView: UIView {
    var isCounting = false
    let startingTime = CountdownTime(minutes: 23, seconds: 00)
    lazy var countdown = Countdown(startingAt: startingTime)
    var timer: Timer?

    @objc func fireTimer() {
        countdown.updateTime()
        let time = countdown.getFormattedTime()
        updateTime(to: time)
        if countdown.secondsRemaining <= 0 {
            isCounting = false
            startPauseButton.setTitle("Start", for: .normal)
            cancelButton.isEnabled = false
            startPauseButton.isEnabled = false
            showStopAlarmButton()
            backgroundColor = .green
            SoundManager.play(sound: .alarm)
            timer?.invalidate()

        }
    }

    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    let topContainerView = UIView()
    let bottomContainerView = UIView()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let startPauseButton: TimerButton = {
        let button = TimerButton()
            button.setTitle("Start", for: .normal)
        return button
    }()

    let cancelButton: TimerButton = {
        let button = TimerButton()
        button.isEnabled = false
        button.setTitle("Cancel", for: .normal)
        return button
    }()

    let stopAlarmButton: TimerButton = {
        let button = TimerButton()
        button.isHidden = true
        button.isEnabled = false
        button.setTitle("Stop", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewStyle()
        setupViewHierarchy()
        setupConstraints()
        setupGestures()
        updateTime(to: countdown.getFormattedTime())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateTime(to text: String) {
        timeLabel.text = text
    }

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }

    private func setupViewHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(topContainerView)
        verticalStackView.addArrangedSubview(bottomContainerView)
        topContainerView.addSubview(timeLabel)
        bottomContainerView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(startPauseButton)
        buttonStackView.addArrangedSubview(cancelButton)
        addSubview(stopAlarmButton)
    }

    private func setupConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

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
            buttonStackView.heightAnchor.constraint(equalToConstant: 60),

            stopAlarmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            stopAlarmButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            stopAlarmButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func showStopAlarmButton() {
        stopAlarmButton.isEnabled = true
        stopAlarmButton.isHidden = false
    }

    private func hideStopAlarmButton() {
        stopAlarmButton.isEnabled = false
        stopAlarmButton.isHidden = true
    }

    @objc func didTapStartPauseButton() {
        backgroundColor = .systemBackground
        if countdown.secondsRemaining <= 0 {
            countdown.resetTime()
            updateTime(to: countdown.getFormattedTime())
        }
        cancelButton.isEnabled = true
        isCounting.toggle()
        let buttonText =  isCounting ? "Pause" : "Start"
        startPauseButton.setTitle(buttonText, for: .normal)
        timer?.invalidate()
        if isCounting {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }

        print("Did tap start pause button isCounting? \(isCounting)")
    }

    @objc func didTapCancelButton() {
        isCounting = false
        timer?.invalidate()
        countdown.resetTime()
        updateTime(to: countdown.getFormattedTime())
        print("Cancel timer")
        cancelButton.isEnabled = false
        startPauseButton.setTitle("Start", for: .normal)
    }

    @objc func didTapStopAlarmButton() {
        SoundManager.stop()
        hideStopAlarmButton()
        startPauseButton.isEnabled = true
        backgroundColor = .systemBackground
        countdown.resetTime()
        updateTime(to: countdown.getFormattedTime())
    }

    private func setupGestures() {
        startPauseButton.addTarget(self, action: #selector(didTapStartPauseButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        stopAlarmButton.addTarget(self, action: #selector(didTapStopAlarmButton), for: .touchDown)
    }
}
