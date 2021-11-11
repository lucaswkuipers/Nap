import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!

    let startingCountInSeconds: Int = 23 * 60
    var currentCountInSeconds: Int
    var timer: Timer?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        currentCountInSeconds = startingCountInSeconds
        let image = UIImage(systemName: "paperplane.fill")
        playButton.setImage(image, for: .highlighted)

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        currentCountInSeconds = startingCountInSeconds
        super.init(coder: coder)
    }
    @IBAction func didTapStart(_ sender: Any) {
        startTimer()
    }

    private func startTimer() {
        timer?.invalidate()
        currentCountInSeconds = startingCountInSeconds
        let minutes = Int((Double(self.currentCountInSeconds) / Double(60)).rounded(.down))
        let seconds = (self.currentCountInSeconds % 60)
        self.counterLabel.text = String(format: "%02d:%02d", minutes, seconds)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.currentCountInSeconds <= 0 {
                timer.invalidate()
            } else {
                self.decreaseTime()
                print("Time left: \(self.currentCountInSeconds)")
                let minutes = Int((Double(self.currentCountInSeconds) / Double(60)).rounded(.down))
                let seconds = (self.currentCountInSeconds % 60)
                self.counterLabel.text = String(format: "%02d:%02d", minutes, seconds)
            }
        }
    }

    private func decreaseTime() {
        currentCountInSeconds -= 1
    }
}
