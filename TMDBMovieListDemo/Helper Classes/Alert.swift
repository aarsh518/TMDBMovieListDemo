//
//  Alert.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class Alert {
    
    static func showNormalAlert(withTitle title: String?, message: String, onController controller: UIViewController) {
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            controller.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
}
