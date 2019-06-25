//
//  View.swift
//  TemplateApp
//
//  Created by Prismea_Strasbourg on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func makesTransparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UIViewController {
    func shareMessage(message: [String], completion: @escaping (_ completed: Bool) -> Void) {
        let uiActivityViewController = UIActivityViewController(activityItems: message, applicationActivities: nil)
        uiActivityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
        ]
        
        uiActivityViewController.completionWithItemsHandler = { (_: UIActivity.ActivityType?, completed: Bool, _: [Any]?, _: Error?) in
            completion(completed)
        }
        
        navigationController?.present(uiActivityViewController, animated: true)
    }
}
