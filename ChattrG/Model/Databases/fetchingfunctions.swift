import UIKit

struct fetchingfunctions {
    static func showAlert(on viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "La", style: .default))
        viewController.present(alert, animated: true)
    }
}
