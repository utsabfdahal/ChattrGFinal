//
//  functions.swift
//  ChattrG
//
//  Created by Utsab's Mac on 26/07/2024.
//

import Foundation
import UIKit
func showAlert(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Aba aucha maza", style: .default))
    present(alert, animated: true)
}
