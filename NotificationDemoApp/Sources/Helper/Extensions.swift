//
//  ExtensionsProtocols.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 30/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func loadImage() -> UIImage?{
        guard let url = URL(string: self) else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        guard let image = UIImage(data: data) else {return nil}
        return image
    }
    
    func replaceSpaces() -> String? {
        let replaced = String(self.map {
            $0 == " " ? "+" : $0
        })
        return replaced
    }
}

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
                self.layer.borderColor = UIColor.black.cgColor
                        self.layer.borderWidth = 1.2;
        self.layer.masksToBounds = true
    }
}


//let aspectRatioConstraint = NSLayoutConstraint(item: self,attribute: .height,relatedBy: .equal,toItem: self,attribute: .width,multiplier: (2.0 / 1.0),constant: 0)
//self.addConstraint(aspectRatioConstraint)
