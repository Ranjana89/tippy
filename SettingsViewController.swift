//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Majmudar, Heshang on 3/9/17.
//  Copyright © 2017 Pokharana, Ranjana. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let tips = [15,18,20]
    let defaultTip: Double? = nil
    var userDefaults : UserDefaults?
    @IBOutlet weak var defaultTipLabel: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userDefaults = UserDefaults.standard
        let tipVal = userDefaults?.integer(forKey: "defaultTip")
        
        defaultTipLabel.selectedSegmentIndex = 0
        
        for (index,tmp) in tips.enumerated(){
            if(tipVal == tmp){
                defaultTipLabel.selectedSegmentIndex = index
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DefaultTip(_ sender: Any) {
        let currTip = tips[defaultTipLabel.selectedSegmentIndex]
        userDefaults?.set(currTip, forKey: "defaultTip")
        userDefaults?.synchronize()
       
    }
    
   }
