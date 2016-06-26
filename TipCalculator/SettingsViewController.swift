//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Meena Sengottuvelu on 6/14/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorControl: UISegmentedControl!
    
    @IBOutlet weak var defaultTip: UISegmentedControl!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        let currencyPosition = defaults.integerForKey("currency")
        
        currencyPickerView.selectRow(currencyPosition, inComponent: 0,animated: true)
        
        //change background color
        if(colorControl.selectedSegmentIndex == 0) {

        } else {

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = view.bounds
            let color1 = UIColor(red:0.24, green:0.52, blue:0.66, alpha:1.0).CGColor
            let color2 = UIColor(red:0.27, green:0.80, blue:0.81, alpha:1.0).CGColor
            let color3 = UIColor(red:0.67, green:0.93, blue:0.85, alpha:1.0).CGColor
            gradient.colors = [color1, color2, color3]
            self.view.layer.insertSublayer(gradient, atIndex: 0)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //let defaults = NSUserDefaults.standardUserDefaults()
        
        let percentIndex = defaults.integerForKey("defaultTipPercent")
        
        let percents = [18, 20, 25]
        defaultTip.removeAllSegments()
        for (index, percentage) in percents.enumerate() {
            defaultTip.insertSegmentWithTitle("\(percentage)%", atIndex: index, animated: true)
        }
        
        defaultTip.selectedSegmentIndex = percentIndex
        
        
        let colorIndex = defaults.integerForKey("defaultColor")
        
        let colors = ["None", "Blue"]
        colorControl.removeAllSegments()
        for (index, color) in colors.enumerate() {
            colorControl.insertSegmentWithTitle("\(color)", atIndex: index, animated: true)
        }
        
        colorControl.selectedSegmentIndex = colorIndex
        
        self.viewDidLoad()
    }
    
    @IBAction func defaultTipSet(sender: AnyObject) {
        
        //let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaultTip.selectedSegmentIndex
        
        defaults.setInteger(index, forKey: "defaultTipPercent")
        
        defaults.synchronize()
        
        self.viewDidLoad()
    }

    @IBAction func defaultColorSet(sender: AnyObject) {
        //let defaults = NSUserDefaults.standardUserDefaults()
        let index1 = colorControl.selectedSegmentIndex

        defaults.setInteger(index1, forKey: "defaultColor")
        
        defaults.synchronize()
        
        self.viewDidLoad()
        
    }
    
    @IBAction func onDone(sender: AnyObject) {
        
        let currency = currencyPickerView.selectedRowInComponent(0)
        defaults.setInteger(currency, forKey: "currency")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyValues.allValues.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var currency : String
        currency = "$"
        if let convertedRank = CurrencyValues(rawValue: row){
            currency = convertedRank.currencyType()
        }
        
        return currency
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


