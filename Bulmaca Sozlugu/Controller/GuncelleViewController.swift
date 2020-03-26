//
//  DuzenleViewController.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 8.03.2020.
//  Copyright © 2020 info. All rights reserved.
//

import UIKit

class GuncelleViewController: UIViewController {

        var gelenKelime:Kelimeler?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let  k = gelenKelime {
                   SoruTextField.text = k.kelime
                   CevapTextField.text = k.kelime_anlam
               }
    }
    @IBOutlet weak var CevapTextField: UITextField!
    @IBOutlet weak var SoruTextField: UITextField!
    

    @IBAction func guncellemeTikladi(_ sender: UIButton) {
     
        if let k = gelenKelime {
        
        if self.CevapTextField.text != "" && self.SoruTextField.text != "" {
            let alertcontroller = UIAlertController(title: "\(CevapTextField.text!)" , message:"Başarıyla Güncellendi" , preferredStyle: .alert)
                   let tamambuton = UIAlertAction(title: "TAMAM", style: .default) {
                       action in
                        
                    KelimelerDao().kelimeGuncelle(kelime_id:k.kelime_id! , Cevap: self.CevapTextField.text!, Soru: self.SoruTextField.text!)
                    
                        
                        self.dismiss(animated: true)
                    }
                    
                   
                   alertcontroller.addAction(tamambuton)
                   self.present(alertcontroller, animated: true)
        }
        
    }
    }
    
}
