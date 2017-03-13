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
        billField.becomeFirstResponder()
        tipControl.selectedSegmentIndex = 0
        userDefaults = UserDefaults.standard
        defaultTip = userDefaults?.integer(forKey: "defaultTip")
        
        for (index,tmp) in tips.enumerated() {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
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
        let bill = Double(billField.text!) ?? 0
        let tip = bill * (Double)(tips[tipControl.selectedSegmentIndex])/100
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        calculateBill(self)
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        calculateBill(self)
    }
}

