//
//  Extenstion.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import UIKit

extension NSError {
    
    convenience init(message:String?, code: Int = 200) {
        
        let errorMessage = message != nil ? message : NSLocalizedString("Ошибка", comment: "")
        
        let userInfo: [String : Any] =
            [
                NSLocalizedDescriptionKey as String : errorMessage as Any
        ]
        
        self.init(domain: "",code: code, userInfo: userInfo)
    }
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
