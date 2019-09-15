//
//  ViewController.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit
import PBRevealViewController
import UICircularProgressRing
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var OverView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var titleProduct: UILabel!
   
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var arrProductInfo : NSMutableArray!
    var itemsPerRow : CGFloat = 2
    var sectionInsets = UIEdgeInsets(top: 15.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    var inventoryNameArray : [String] = ["Product","Inward","Outward","Transaction"]
    
    var inventoryImgArray : [String] = ["product","inward","outward","transaction"]

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func initialSetup(){
      
   
        menuBtn.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchDown)
        
//        valuetitleProductView.setShadow()
//        valueProductBtn.titleLabel?.setShadow()
//
        
      //  valueProductBtn.setShadow()
    }
    func getProductData()
    {
        arrProductInfo = NSMutableArray()
        arrProductInfo = ModelManager.getInstance().getAllProductData()
progressRing.value = CGFloat(Float(self.arrProductInfo!.count))
        progressRing.maxValue = 100
      

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
           UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
        getProductData()
    print(inventoryNameArray.count)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventoryNameArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let inventorycellObj : inventoryCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "inventorycell", for: indexPath) as! inventoryCell
        
        inventorycellObj.contentView.setShadow()
inventorycellObj.inventoryName.textColor = UIColor.white
        if indexPath.item == 0{
            inventorycellObj.contentView.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
            inventorycellObj.inventoryName.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
        }else if indexPath.item == 1 {
             inventorycellObj.contentView.backgroundColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
         inventorycellObj.inventoryName.backgroundColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
        }else if indexPath.item == 2 {
             inventorycellObj.contentView.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            inventorycellObj.inventoryName.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        }else  {
             inventorycellObj.contentView.backgroundColor =  UIColor.init(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
            inventorycellObj.inventoryName.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
        }
        
        
        inventorycellObj.inventoryName.text = inventoryNameArray[indexPath.row]
        inventorycellObj.inventoryImg.image = UIImage.init(named: inventoryImgArray[indexPath.row])
        inventorycellObj.inventorycellView.clipsToBounds = true
        inventorycellObj.setShadow()
        
        return inventorycellObj
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            let inventoryObj : InventorVC = self.storyboard?.instantiateViewController(withIdentifier: "Inventorvc") as! InventorVC
            self.navigationController?.pushViewController(inventoryObj, animated: true)
        }else if indexPath.item == 1 {
            let inverdVCObj : InverdVC = self.storyboard?.instantiateViewController(withIdentifier: "Inverdvc") as! InverdVC
            self.navigationController?.pushViewController(inverdVCObj , animated: true)
        }else if indexPath.item == 2 {
            let outverdvcObj : outverdVC = self.storyboard?.instantiateViewController(withIdentifier: "outverdvc") as! outverdVC
            self.navigationController?.pushViewController(outverdvcObj, animated: true)
        }else if indexPath.item == 3 {
            let transactionvcObj : TransactionVC = self.storyboard?.instantiateViewController(withIdentifier: "Transactionvc") as! TransactionVC
            self.navigationController?.pushViewController(transactionvcObj, animated: true)
        }else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem , height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension UICollectionView {
    func indexPathForView(view: AnyObject) -> IndexPath? {
        let originInCollectioView = self.convert(CGPoint.zero, from: (view as! UIView))
        return self.indexPathForItem(at: originInCollectioView) as IndexPath?
    }
}

