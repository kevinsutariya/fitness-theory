//
//  BMICalculatorVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 25/07/22.
//

import UIKit

class BMICalculatorVC: UIViewController {

    @IBOutlet weak var lblHeightTitle: UILabel!
    @IBOutlet weak var lblHeightUnit: UILabel!
    @IBOutlet weak var txtHeight: UITextField!
    
    @IBOutlet weak var lblWeightTitle: UILabel!
    @IBOutlet weak var lblWeightUnit: UILabel!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var btnResult: UIButton!
    @IBOutlet weak var lblBMITableTitle: UILabel!
    @IBOutlet weak var imgBMITable: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblBMITableTitle.isHidden = true
        imgBMITable.isHidden = true
        
        lblHeightTitle.text = "height".localized
        lblHeightUnit.text = "cm".localized
        
        lblWeightTitle.text = "weight".localized
        lblWeightUnit.text = "kg".localized
        
        btnResult.setTitle("Result".localized, for: .normal)
        lblBMITableTitle.text = "BMI table".localized
    }
    
    // MARK: - UIBUTTON CLICK METHODS
    @IBAction func onClickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickResult(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        if txtHeight.text?.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "Enter height.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if txtWeight.text?.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "Enter weight.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.view.endEditing(true)
        
        lblBMITableTitle.isHidden = false
        imgBMITable.isHidden = false
    }
    

}
