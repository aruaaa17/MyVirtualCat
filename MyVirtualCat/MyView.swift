//
//  MyView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 8/9/23.
//

import Foundation
import SwiftUI

struct MyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MyViewController
    
    func makeUIViewController(context: Context) -> MyViewController {
        // Return MyViewController instance
        let vc = MyViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
    
}
