//
//  SettingsViewController.swift
//  tips
//
//  Created by Lyn Han on 12/23/15.
//  Copyright © 2015 lyn. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    // set default selection
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    
    // set tip percentages
    @IBOutlet weak var oneInput: UITextField!
    @IBOutlet weak var twoInput: UITextField!
    @IBOutlet weak var threeInput: UITextField!
    
    @IBOutlet var inputs: Array<UITextField>?
    @IBOutlet var buttons: Array<UIButton>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = ""
        inputs = [oneInput, twoInput, threeInput]
        buttons = [oneButton, twoButton, threeButton]
        
        // display current tip percentages
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tipOne = defaults.stringForKey("0") {
            oneInput.text = String(tipOne)
        }
        if let tipTwo = defaults.stringForKey("1") {
            twoInput.text = String(tipTwo)
        }
        if let tipThree = defaults.stringForKey("2") {
            threeInput.text = String(tipThree)
        }
        if let index = defaults.stringForKey("selectIndex") {
            setDefaultButton(NSString(string:index).integerValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeTip(sender: UITextField) {
        if let newTipInt = Int(sender.text!) { // valid int
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(String(newTipInt), forKey:String(sender.tag))
            statusLabel.text = "Saved!"
        }
        else {
            statusLabel.text = "Bad whole number."
        }
        statusLabel.textColor = UIColor.lightGrayColor()
    }

    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        let scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    @IBAction func setDefaultSelection(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentDefaultButtonIndex = sender.tag
        let previousIndex = defaults.stringForKey("selectIndex")
        if previousIndex != String(currentDefaultButtonIndex) {
            defaults.setObject(currentDefaultButtonIndex, forKey: "selectIndex")
            setDefaultButton(currentDefaultButtonIndex)
        }
    }
    
    func setDefaultButton(currentIndex: Int) {
        for button in buttons! {
            if button.tag == currentIndex {
                button.setTitle("Default", forState: UIControlState.Normal)
                button.setTitleColor(UIColorFromRGB("25B8B8"), forState: UIControlState.Normal)
            }
            else {
                button.setTitle("Set default", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
