//
//  ViewController.swift
//  Bulmaca Sozlugu
//
//  Created by Bekir Duran on 30.01.2020.
//  Copyright © 2020 info. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    var kelimeListesi = [Kelimeler]()
    var aramayapiliyormu = false
    var aramaKelime:String?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        veriTabaniCopy()
        kelimeListesi = KelimelerDao().tumKisileriOku()
        
        KelimeTableView.delegate = self
        KelimeTableView.dataSource = self
        seatchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
         kelimeListesi = KelimelerDao().tumKisileriOku()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mainTodetay" {
            let indeks = sender as? Int
            let vc = segue.destination as! DetayViewController
            vc.gelenKelime = kelimeListesi[indeks!]
        }
        else if segue.identifier == "mainToadd"{
        }
        else if segue.identifier == "mainToGuncelle"{
            let indeks = sender as? Int
            let vc = segue.destination as! GuncelleViewController
            vc.gelenKelime = kelimeListesi[indeks!]
        }
        
    }
    
    func veriTabaniCopy () {
        let bundleYolu = Bundle.main.path(forResource: "bulmaca", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("bulmaca.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten kopyalandı")
        }
        else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                print("Veritabanı zaten kopyalandı")
            } catch  {
                print(error)
            }
        }
        
        
    }




    @IBOutlet weak var KelimeTableView: UITableView!
    @IBOutlet weak var seatchBar: UISearchBar!
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeHucreTableViewCell
        cell.labelKelime.text = kelime.kelime
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "mainTodetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let sil = UITableViewRowAction(style: .default, title: "SİL", handler: {
            (action: UITableViewRowAction, indexPath:IndexPath)-> Void in
            print("Sil tıklandı \(self.kelimeListesi[indexPath.row].kelime_anlam!)")
            KelimelerDao().kelimeSil(kelime_id: self.kelimeListesi[indexPath.row].kelime_id!)
            print("Silindi \(self.kelimeListesi[indexPath.row].kelime_anlam!)")
            if self.aramayapiliyormu == false{
                self.kelimeListesi = KelimelerDao().tumKisileriOku()
                   }
                   else{
                self.kelimeListesi = KelimelerDao().aramaYap(arama: self.aramaKelime!)
                   }
                self.KelimeTableView.reloadData()

        })
        let guncelle = UITableViewRowAction(style: .normal, title: "GÜNCELLE", handler: {
                   (action: UITableViewRowAction, indexPath:IndexPath)-> Void in
            print("Güncelle tıklandı \(self.kelimeListesi[indexPath.row].kelime_anlam!)")
            self.performSegue(withIdentifier: "mainToGuncelle", sender: indexPath.row)
               })
     return [sil,guncelle]
    }
    
    
}

extension MainViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("Arama sonucu : \(searchText)")
            aramayapiliyormu = true
            aramaKelime = searchText
            kelimeListesi = KelimelerDao().aramaYap(arama: searchText)
            KelimeTableView.reloadData()

        }
    
}
