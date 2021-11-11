import UIKit

struct TimerViewComposer {
    static func makeScene() -> UIViewController {
//        let view = UIView()
//        view.backgroundColor = .red
        let view = TimerView()
        let viewController = BaseViewController(from: view)

        return viewController
    }
}
