//
//  CustomExtentions.swift
//  Twissue
//
//  Created by Deforeturn on 4/18/22.
//

import UIKit

extension UIButton{
    func animateScaleUpDown() {
        let impactGenerator = UIImpactFeedbackGenerator()
        impactGenerator.impactOccurred(intensity: 0.5)
        UIView.animate(withDuration: 0.1, delay: .nan, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }){ _ in
            UIView.animate(withDuration: 0.1, delay: .nan, options: .curveEaseOut){
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
