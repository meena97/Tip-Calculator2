//
//  ViewController.swift
//  TipCalculator
//
//  Created by Meena Sengottuvelu on 6/14/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var tipLabelSlider: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var partyNumLabel: UILabel!
    
    @IBOutlet weak var neutral: UIImageView!
    @IBOutlet weak var happy: UIImageView!
    @IBOutlet weak var excited: UIImageView!
    
    
    var splitStepperVal: Double! = 1
    
    var colorSetting = 0
    
    let defaults = NSUserDefaults.standardUserDefaults();
    
    var faces: [UIImageView] {
        return [neutral, happy, excited]
    }
    
    let selectedFace = CGFloat(1.0)
    let deselectedFace = CGFloat(0.10)
    
    private var currency = "$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder();
        
        splitStepper.value = 1
        
        //change background color
        if(colorSetting == 0) {

        } else {
            // Create background gradient
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [UIColor(red:0.24, green:0.52, blue:0.66, alpha:1.0).CGColor,UIColor(red:0.27, green:0.80, blue:0.81, alpha:1.0).CGColor, UIColor(red:0.67, green:0.93, blue:0.85, alpha:1.0).CGColor]
            self.view.layer.insertSublayer(gradient, atIndex: 0)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateFaces() {
        UIView.animateWithDuration(0.5, animations: {
            for (index, face) in self.faces.enumerate() {
                if self.tipControl.selectedSegmentIndex == index {
                    face.alpha = self.selectedFace
                } else {
                    face.alpha = self.deselectedFace
                }
            }
        })
    }
    
    @IBAction func splitStepperValChange(sender: AnyObject) {
        splitStepperVal = sender.value
        calcTip()
    }
    
    override func viewWillAppear(animated: Bool) {
        //let defaults = NSUserDefaults.standardUserDefaults()
        
        navigationController?.hidesBarsWhenKeyboardAppears = true
        
        let currencyPosition = defaults.integerForKey("currency")
        
        if let convertedRank = CurrencyValues(rawValue: currencyPosition){
            currency = convertedRank.symbol()
        }
        
        let percentSetting = defaults.integerForKey("defaultTipPercent")
        
        colorSetting = defaults.integerForKey("defaultColor")
        
        let tipPercentages = [18, 20, 25]
        tipControl.removeAllSegments()
        for (index, percentage) in tipPercentages.enumerate() {
            tipControl.insertSegmentWithTitle("\(percentage)%", atIndex: index, animated: true)
        }
        
        tipControl.selectedSegmentIndex = percentSetting
        
        updateToPrevious()
        
        self.viewDidLoad()
        
    }

    
    func updateToPrevious() {
        
        let currentDate = NSDate.timeIntervalSinceReferenceDate()
        
        if (currentDate - defaults.doubleForKey("previousDate")) < (10 * 60) {
            let nf = NSNumberFormatter()
            nf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            nf.currencySymbol = currency
            let tipPercentages = [0.18, 0.2, 0.25]
            billField.text = nf.stringFromNumber(defaults.doubleForKey("previousBill"))
            let tip = (defaults.doubleForKey("previousBill")) * tipPercentages[tipControl.selectedSegmentIndex]
            tipLabel.text = String(format: "$%.2f", tip)
        }

    }
    
    private func updateLabel(label: UILabel, value: Double){
        let nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        nf.currencySymbol = currency
        
        label.text = nf.stringFromNumber(value)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        calcTip()

    }
    
    func calcTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        let splitAmt = String(format: "$%.2f", total/(splitStepperVal))
        
        
        if (splitStepperVal == 1) { // use text for split values less than ten
            partyNumLabel.text = "Party of " + String(Int(splitStepperVal))
            totalLabel.text = "you pay \(splitAmt)"
        } else {
            partyNumLabel.text = "Party of " + String(Int(splitStepperVal))
            totalLabel.text = "each pays \(splitAmt)"
        }
        
        updateLabel(tipLabel, value: tip)
        updateLabel(totalLabel, value: total)
        
        updateFaces()
        
        defaults.setDouble(bill, forKey: "previousBill")
        defaults.setDouble(tip, forKey: "previousTip")
        defaults.setDouble(NSDate.timeIntervalSinceReferenceDate(), forKey: "previousDate")
        
        defaults.synchronize()
    }

    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let tipPercentageUnsplit = Int(tipSlider.value)
        let tipPercentage = Double(tipPercentageUnsplit) / 100.0
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip

        tipLabelSlider.text = String(format: "%d%%", tipPercentageUnsplit)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = "Each pays " + String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
}

