//
//  UIViewController.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/18/24.
//

import Foundation

import UIKit

extension UIViewController {
    
    func startLoading(asProgress: Bool = false, title: String? = nil, message: String? = nil, completion: (() -> Void)? = nil) -> ((Double, String?) -> Void)? {
        if asProgress {
            let alert = UIAlertController(title: title ?? LS("Loading"), message: message, preferredStyle: .alert)
            alert.restorationIdentifier = "loadingAlert"
            
            let progressView = UIProgressView()
            progressView.trackTintColor = .foregroundColor
            progressView.progressTintColor = .accentColor
            
            alert.view.addSubview(progressView)
            
            let safeArea = alert.view.layoutMarginsGuide
            
            progressView.snp.makeConstraints { (make) in
                make.edges.equalTo(safeArea).inset(UIEdgeInsets(top: 80, left: 0, bottom: 20, right: 0))
            }
            
            present(alert, animated: true, completion: completion)
            
            return { (newProgressValue, newMessage) in
                alert.message = newMessage ?? alert.message
                progressView.setProgress(Float(newProgressValue), animated: true)
            }
        } else {
            let alert = UIAlertController(title: nil, message: LS("Loading"), preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            alert.restorationIdentifier = "loadingAlert"
            self.present(alert, animated: true, completion: completion)
        }
        
        return nil
    }
    
    func endLoading(completion: (() -> Void)? = nil) {
        if self.presentedViewController?.restorationIdentifier == "loadingAlert" {
            self.presentedViewController?.dismiss(animated: true, completion: completion)
        } else {
            if completion != nil {
                completion!()
            }
        }
        
    }
    
    private func displayDismissableAlert(withTitle title: String, message: String, dismissAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert,
            options: [
                (
                    title: LS("Okay"),
                    style: .cancel,
                    action: dismissAction
                )
            ]
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayError(withMessage message: String, dismissAction: ((UIAlertAction) -> Void)? = nil) {
        displayDismissableAlert(withTitle: LS("Error"), message: message, dismissAction: dismissAction)
    }
    
    func displayInfoAlert(withMessage message: String, dismissAction: ((UIAlertAction) -> Void)? = nil) {
        displayDismissableAlert(withTitle: LS("Info"), message: message, dismissAction: dismissAction)
    }
    
    func displayOpenSettingsAlert(withTitle title: String, message: String, dismissAction: (() -> Void)? = nil) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert,
            options: [
                (
                    title: LS("Cancel"),
                    style: .cancel,
                    action: { _ in
                        dismissAction?()
                    }
                ),
                (
                    title: LS("Open"),
                    style: .default,
                    action: { _ in
                        if let url = URL.init(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            print(url)
                        }
                        dismissAction?()
                    }
                )
            ]
        )
        self.present(alert, animated: true)
        
    }
    
    func findFirstNonTabOrNavigationController() -> UIViewController {
        self.goThroughControllerTree { (controller) -> Bool in
            !(controller is UINavigationController) && !(controller is UITabBarController)
        }
    }
    
    private func goThroughControllerTree(filter: (UIViewController) -> Bool) -> UIViewController {
        for child in self.children {
            if filter(child) {
                return child
            } else {
                return child.goThroughControllerTree(filter: filter)
            }
        }
        return self
    }
    
}
