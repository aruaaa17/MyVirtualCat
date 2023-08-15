//
//  MyView.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 8/9/23.
//

import Foundation
import SwiftUI

struct MyView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MyViewController
    
    @Binding var currentNumber: Int

    init(currentNumber: Binding<Int>) {
        self._currentNumber = currentNumber
    }
    
    func makeUIViewController(context: Context) -> MyViewController {
        
        // Return MyViewController instance
        // Do some configurations here if needed.
        let vc = MyViewController(number: self.currentNumber)
        vc.currentNumberInLabel = self.currentNumber
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        uiViewController.currentNumberInLabel = self.currentNumber
    }
    
}
