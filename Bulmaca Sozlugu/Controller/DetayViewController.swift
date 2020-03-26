//
//  DetayViewController.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 30.01.2020.
//  Copyright © 2020 info. All rights reserved.
//

import UIKit

class DetayViewController: UIViewController {
    
    var gelenKelime:Kelimeler?

    @IBOutlet weak var labelKelime: UILabel!
    @IBOutlet weak var labelAnlam: UILabel!
    override func viewDidLoad() {
   

        if let  k = gelenKelime {
            labelKelime.text = k.kelime
            labelAnlam.text = k.kelime_anlam
        }
        super.viewDidLoad()

    }
    

}
