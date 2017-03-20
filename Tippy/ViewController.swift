//
//  ViewController.swift
//  Tippy
//
//  Created by Majmudar, Heshang on 3/9/17.
//  Copyright © 2017 Pokharana, Ranjana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let tips = [15,18,20]
    var defaultTip : Int?
    var userDefaults : UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        //show the decimal pad as soon as viewappear
        billField.becomeFirstResponder()
        
        //write the placeholder text
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        billField.attributedPlaceholder = NSAttributedString(string: currencyFormatter.string(from : 0)!)
        
        
        tipControl.selectedSegmentIndex = 0
        userDefaults = UserDefaults.standard
        defaultTip = userDefaults?.integer(forKey: "defaultTip")
        
        for (index,tmp) in tips.enumerated() {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        
        //remember the bill from a recent* previous session (60*10 = 10 minutes)
            if (userDefaults?.object(forKey: "default_bill") != nil) {
                let now = NSDate()
                let previous = userDefaults?.object(forKey: "time_at_close")!
                if (now.timeIntervalSince(previous as! Date) < 60 * 10 ) {
                    billField.text = userDefaults?.object(forKey: "default_bill") as! String!
                }
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        billField.becomeFirstResponder()
        defaultTip = userDefaults?.integer(forKey: "defaultTip")
        for (index,tmp) in tips.enumerated() {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        userDefaults?.set(billField.text, forKey: "default_bill")
        userDefaults?.set(NSDate(),forKey : "time_at_close")
        userDefaults?.synchronize()
        calculateBill(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        calculateBill(self)
    }
    
    @IBAction func calculateBill(_ sender: Any) {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
       
        
        let bill = Double(billField.text!) ?? 0
        let tip = (bill * (Double)(tips[tipControl.selectedSegmentIndex])/100)
        let tipValue = tip as NSNumber
        let total = (bill + tip ) as NSNumber
        
        tipLabel.text = currencyFormatter.string(from: tipValue)
        //String(format: "$%.2f", tip)
        totalLabel.text = currencyFormatter.string(from: total)
            //String(format: "$%.2f", total)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        calculateBill(self)
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        calculateBill(self)
    }
}

