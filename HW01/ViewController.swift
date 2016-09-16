
//  ViewController.swift
//  HW01
//
//  Created by student on 7/10/16.
//  Copyright (c) 2016 itcs6010mnr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private var billAmountValue = 0.0
    private var tipAmountValue = 0.0
    private var totalAmountValue = 0.0
    private var tipPercent = 10.0
    
    @IBOutlet weak var billAmount: UITextField!
    
    @IBAction func billAmountChanged(sender: UITextField) {
        let billVal = billAmount.text
        if let billAmountVal = Double(billVal!) {
            if billAmountVal > 0 {
                billAmountValue = billAmountVal
                calculateTotalAmount()
            } else {
                let alert = UIAlertController(title: "Alert", message: "Enter Positive Values", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            if billVal != "" {
                let alert = UIAlertController(title: "Alert", message: "Enter Valid Bill Amount", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                billAmountValue = 0
                calculateTotalAmount()
            }
        }
    }
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBAction func tipChanged(sender: AnyObject) {
        switch tipSegment.selectedSegmentIndex{
        case 0:
            tipPercent = 10
            calculateTotalAmount()
            updateTipSlider(10)
        case 1:
            tipPercent = 15
            calculateTotalAmount()
            updateTipSlider(15)
        case 2:
            tipPercent = 18
            calculateTotalAmount()
            updateTipSlider(18)
        case 3:
            calculateTotalAmount()
        default:
            break
        }
        
    }
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let currentValue = Double(slider.value)
        let currentValueDisplay = String(format: "%.2f", currentValue)
        customTipValue.text = "\(currentValueDisplay)%"
        tipPercent = currentValue
        if tipSegment.selectedSegmentIndex == 3 {
            calculateTotalAmount()
        }
    }

    @IBOutlet weak var customTipValue: UILabel!
    
    @IBOutlet weak var tipAmount: UILabel!
   
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBAction func clearFields(sender: AnyObject) {
        customTipValue.text = "25%"
        self.slider.value = 25
        billAmountValue = 0.0
        tipAmountValue = 0.0
        totalAmountValue = 0.0
        tipPercent = 10.0
        billAmount.text = ""
        self.tipSegment.selectedSegmentIndex = 0
    }
    private func calculateTotalAmount() {
        tipAmountValue = ( billAmountValue * tipPercent ) / 100
        let tipAmountValueStr = String(format: "%.2f", tipAmountValue)
        tipAmount.text = "\(tipAmountValueStr)"
        totalAmountValue = billAmountValue + tipAmountValue
        let totalAmountValueStr = String(format: "%.2f", totalAmountValue)
        totalAmount.text = "\(totalAmountValueStr)"
    }
    
    private func updateTipSlider(tip: Int) {
        customTipValue.text = "\(tip)%"
        self.slider.value = Float(tip)
    }
}

