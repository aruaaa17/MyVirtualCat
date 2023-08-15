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
//        label.text = "🩷🩷🩷🩷🩷"
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "\(currentNumberInLabel) 🩷"
        view = label

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    func updateLable() {
        label.text = "\(currentNumberInLabel) ❤️"
    }
}
