import UIKit

struct TimerViewComposer {
    static func makeScene() -> UIViewController {
        let view = TimerView()
        let viewController = BaseViewController(from: view)

        return viewController
    }
}
