//
//  ColorViewController.swift
//  TipCalculator
//
//  Created by Meena Sengottuvelu on 6/19/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var currentTheme: Theme = Theme.DEFAULT
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.applyTheme(currentTheme)
    }
    
    final func applyTheme(theme: Theme) {
        switch theme {
        case Theme.DARK:
            
            // Create background gradient
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [UIColor(red:0.24, green:0.52, blue:0.66, alpha:1.0).CGColor,UIColor(red:0.27, green:0.80, blue:0.81, alpha:1.0).CGColor, UIColor(red:0.67, green:0.93, blue:0.85, alpha:1.0).CGColor]
            self.view.layer.insertSublayer(gradient, atIndex: 0)
            
            break
        default:
            self.view.backgroundColor = UIColor.whiteColor()
            // Note: Setting this to nil doesn't always work. Manually set to "iOS blue".
            UIView.appearance().tintColor =
                UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
            UILabel.appearance().tintColor = nil
            UILabel.appearance().textColor = nil
            UITextField.appearance().backgroundColor = nil
            UITextField.appearance().textColor = nil
            UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.Light
            self.navigationController!.navigationBar.barTintColor = nil
            self.navigationController!.navigationBar.tintColor = nil
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        
        currentTheme = theme
        
        // Found this on StackOverflow:
        // http://stackoverflow.com/questions/20875107/
        // Force the current view to redraw after changes are made.
        if let superView = self.view.superview {
            let currentView = self.view
            currentView.removeFromSuperview()
            superView.addSubview(currentView)
        }
    }
}

enum Theme: Int {
    case DEFAULT = 0, DARK = 1
}
