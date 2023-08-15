//
//  MyViewController.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 8/9/23.
//

import Foundation
import UIKit
import FocusEntity
import ARKit
import SwiftUI

class MyViewController: UIViewController, UIGestureRecognizerDelegate {
    var currentNumberInLabel: Int
    

    init(number: Int) {
        self.currentNumberInLabel = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
//        label.text = "🩷🩷🩷🩷🩷"
        label.textAlignment = .center
        label.textColor = .systemPink
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        if currentNumberInLabel == 0 {
            label.text = "\(currentNumberInLabel) 🖤 \n \n \n Hey I'm still here! \n Play with me plzzzz 😿"
        } else if currentNumberInLabel > 5 {
            label.text = "\(currentNumberInLabel) 🩷 \n \n \n Did I mention that I love you so much 😻"
        } else {
            label.text = "\(currentNumberInLabel) 🩵 \n \n \n I think you can love me more 😽"
        }
        view = label

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
}
