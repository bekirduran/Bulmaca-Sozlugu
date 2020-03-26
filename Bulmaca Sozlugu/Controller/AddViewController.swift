//
//  AddViewController.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 8.03.2020.
//  Copyright © 2020 info. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var CevapTextField: UITextField!
    @IBOutlet weak var SoruTextfield: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func EkleTiklandi(_ sender: Any) {
         if self.CevapTextField.text != "" && self.SoruTextfield.text != "" {
        let alertcontroller = UIAlertController(title: "\(CevapTextField.text!)" , message:"Başarıyla Eklendi" , preferredStyle: .alert)
               let tamambuton = UIAlertAction(title: "TAMAM", style: .default) {
                   action in
               
                    KelimelerDao().kelimeEkle(Cevap: self.CevapTextField.text!, Soru: self.SoruTextfield.text!)
                    self.CevapTextField.text = ""
                    self.SoruTextfield.text = ""
                    
                    self.dismiss(animated: true)
                }
                
               
               alertcontroller.addAction(tamambuton)
               self.present(alertcontroller, animated: true)
    }
    
    }


}
