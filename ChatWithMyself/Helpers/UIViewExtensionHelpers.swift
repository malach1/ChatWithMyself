//
//  UIViewExtensionHelpers.swift
//  GitHubChat
//
//  Created by Malachi Hul on 2021/08/12.
//

import UIKit

extension UIView {
    
    func pinToEdges(to superView:UIView) {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}
