//
//  KelimelerDao.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 30.01.2020.
//  Copyright © 2020 info. All rights reserved.
//

import Foundation

class KelimelerDao {
    
      let db : FMDatabase?
      
      init() { // veritabanına ulaşma kodu
          let hedefYOl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
          let veriTabaniURL = URL(fileURLWithPath: hedefYOl).appendingPathComponent("bulmaca.sqlite")
          db = FMDatabase(path: veriTabaniURL.path)
      }
    
    func tumKisileriOku () -> [Kelimeler] { // sorgu ile veritabanındakileri while dongusu sayesinde satır satır çekme komutu
          var liste = [Kelimeler]()
          db?.open()
          do {
              let rs = try db!.executeQuery("SELECT * FROM kelimeler", values: nil)
             
              while rs.next() {
                let k = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id"))!, kelime: rs.string(forColumn: "kelime")!, kelime_anlam: rs.string(forColumn: "kelime_anlam")!)
                  
                  liste.append(k)
              }
              
                 } catch  {
                     print(error.localizedDescription)
                 }
                 db?.close()
          
          return liste
      }
    
    func aramaYap (arama:String) -> [Kelimeler] { // sorgu ile veritabanındakileri while dongusu sayesinde satır satır çekme komutu
              var liste = [Kelimeler]()
              db?.open()
              do {
                  let rs = try db!.executeQuery("SELECT * FROM kelimeler WHERE kelime like '%\(arama)%'", values: nil)
                 
                  while rs.next() {
                      let k = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id"))!, kelime: rs.string(forColumn: "kelime")!, kelime_anlam: rs.string(forColumn: "kelime_anlam")!)
                                       
                                       liste.append(k)
                  }
                  
                     } catch  {
                         print(error.localizedDescription)
                     }
                     db?.close()
              
              return liste
          }
    
    func kelimeEkle (Cevap:String,Soru:String){ // veritabanına kisi ekleme komutu
        db?.open()
      
        do {
            try db!.executeUpdate("INSERT INTO kelimeler (kelime,kelime_anlam) VALUES (?,?)", values: [Soru,Cevap])
           
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func kelimeSil (kelime_id:Int){ // veritabanına kisi silme komutu
           db?.open()
         
           do {
               try db!.executeUpdate("DELETE FROM kelimeler WHERE kelime_id = ?", values: [kelime_id])
              
           } catch  {
               print(error.localizedDescription)
           }
           db?.close()
       }
       
    func kelimeGuncelle (kelime_id:Int, Cevap:String,Soru:String){ // veritabanına kisi güncelleme komutu
        db?.open()
      
        do {
            try db!.executeUpdate("UPDATE kelimeler SET kelime = ?, kelime_anlam = ? WHERE kelime_id = ?", values: [Soru,Cevap,kelime_id])
           
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }


}
