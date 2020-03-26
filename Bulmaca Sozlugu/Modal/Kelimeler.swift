//
//  Kelimeler.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 30.01.2020.
//  Copyright © 2020 info. All rights reserved.
//

import Foundation

class Kelimeler {
    var kelime_id:Int?
    var kelime:String?
    var kelime_anlam:String?
    
    init(kelime_id:Int,kelime:String,kelime_anlam:String) {
        
        self.kelime_id = kelime_id
        self.kelime=kelime
        self.kelime_anlam=kelime_anlam
    }
}
