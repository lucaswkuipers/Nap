import UIKit

final class BaseViewController: UIViewController {
    init(from view: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.view = view
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
