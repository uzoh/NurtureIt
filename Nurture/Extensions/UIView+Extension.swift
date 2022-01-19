//
//  UIView+Extension.swift
//  Nurture
//
//  Created by Uzoh Okwara on 6/15/21.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
