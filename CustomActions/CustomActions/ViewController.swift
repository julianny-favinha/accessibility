//
//  ViewController.swift
//  CustomActions
//
//  Created by Julianny Favinha on 25/09/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTapGestures()
        setupAccessibilityCustomActions()
    }

    private func setupTapGestures() {
        let text = "Please agree for Terms & Conditions"
        label.text = text

        let attributedText = NSMutableAttributedString(string: text)
        let termsRange = (text as NSString).range(of: "Terms")
        let conditionsRange = (text as NSString).range(of: "Conditions")

        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: conditionsRange)

        label.attributedText = attributedText

        let tapGesture = AttributedLabelTapGestureRecognizer(target: self, action: #selector(didTapLabel(gesture:)))
        label.addGestureRecognizer(tapGesture)

        label.isUserInteractionEnabled = true
    }

    private func setupAccessibilityCustomActions() {
        let termsCustomAction = UIAccessibilityCustomAction(
            name: "Terms",
            target: self,
            selector: #selector(displayTermsOfUse)
        )

        let privacyCustomAction = UIAccessibilityCustomAction(
            name: "Conditions",
            target: self,
            selector: #selector(displayConditions)
        )

        label.accessibilityCustomActions = [
            termsCustomAction,
            privacyCustomAction
        ]
    }

    @objc
    private func didTapLabel(gesture: AttributedLabelTapGestureRecognizer) {
        guard let text = label.text else { return }

        let termsRange = (text as NSString).range(of: "Terms")
        let conditionsRange = (text as NSString).range(of: "Conditions")

        if gesture.didTapAttributedTextInLabel(label: label, inRange: termsRange) {
            displayTermsOfUse()
        } else if gesture.didTapAttributedTextInLabel(label: label, inRange: conditionsRange) {
            displayConditions()
        }
    }

    @objc
    private func displayTermsOfUse() {
        displayAlert(title: "Displaying terms")
    }

    @objc
    private func displayConditions() {
        displayAlert(title: "Displaying conditions")
    }

    private func displayAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

