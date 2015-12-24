//
//  ViewController.swift
//  tips
//
//  Created by Lyn Han on 12/23/15.
//  Copyright © 2015 lyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    var tipPercentages : [Double] = [0.18, 0.2, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tipOne = defaults.stringForKey("0") {
            tipPercentages[0] = NSString(string:tipOne).doubleValue*0.01
            tipControl.setTitle(String(tipOne)+"%", forSegmentAtIndex: 0)
        }
        if let tipTwo = defaults.stringForKey("1") {
            tipPercentages[1] = NSString(string:tipTwo).doubleValue*0.01
            tipControl.setTitle(String(tipTwo)+"%", forSegmentAtIndex: 1)
        }
        if let tipThree = defaults.stringForKey("2") {
            tipPercentages[2] = NSString(string:tipThree).doubleValue*0.01
            tipControl.setTitle(String(tipThree)+"%", forSegmentAtIndex: 2)
        }
        if let bill = defaults.stringForKey("bill") {
            billField.text = bill
        }
        if let selectIndex = defaults.stringForKey("selectIndex") {
            tipControl.selectedSegmentIndex = NSString(string: selectIndex).integerValue
        }
        billField.becomeFirstResponder()
        onEditingChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "bill")
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

