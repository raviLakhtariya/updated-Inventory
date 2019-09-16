//
//  AddImgVC.swift
//  Inventory
//
//  Created by Janki on 16/09/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class AddImgVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    let picker = UIImagePickerController()
    var isPickAdded : Bool!
    var onImageSelected : ((UIImage) -> Void)? = nil
    var imageadded : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.imageview.image = imageadded
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
       // _ = self.navigationController?.popViewController(animated: true)
        if imageview.image == nil {
            
        }else{
            if imageview.image == UIImage.init(named: "asset-placeholder"){
                
            }else{
                isPickAdded = true
                self.imageadded = imageview.image!
            }
            
        }
        self.performSegue(withIdentifier: "saveImage", sender: self)
        print(imageadded )
    }
    
    @IBAction func onClickGallaryBtn(_ sender: Any) {
        
        picker.navigationBar.tintColor = UIColor.black;
        picker.navigationBar.barTintColor = UIColor.white
        picker.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black]
        
        
        picker.allowsEditing = true
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        parent?.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onClickCameraBtn(_ sender: Any) {
        picker.navigationBar.tintColor = UIColor.black;
        picker.navigationBar.barTintColor = UIColor.white
        picker.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black]
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
            
        {
            picker.sourceType =   .camera
            picker.mediaTypes =   UIImagePickerController.availableMediaTypes(for: .camera)!
            picker.cameraFlashMode = .on
            
            parent?.present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Camera Error", message: "Camera is not available", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            parent!.present(alertController, animated: true, completion: nil)
        }

    }
    @IBAction func onClickBtnSkip(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickNextBtn(_ sender: Any) {
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if imageview.image == nil {
            
        }else{
            if imageview.image == UIImage.init(named: "asset-placeholder"){
                
            }else{
                isPickAdded = true
                self.imageadded = imageview.image!
            }

        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            imageview.image = image
            if self.onImageSelected != nil
            {
                onImageSelected!(imageview.image!)
                
                if imageview.image == UIImage.init(named: "asset-placeholder"){
                    
                }else{
                    isPickAdded = true
                    self.imageadded = imageview.image!
                }

            }
            
            
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           imageview.image = image
            if self.onImageSelected != nil
            {
                onImageSelected!(imageview.image!)
//                self.imageadded = imageview.image!
//                isPickAdded = true
                if imageview.image == UIImage.init(named: "asset-placeholder"){
                    
                }else{
                    isPickAdded = true
                    self.imageadded = imageview.image!
                }
            }
            
        }
        else
        {
            imageview.image = nil
            isPickAdded = false
        }
        
        parent?.dismiss(animated: true, completion: nil)
    }
    



}
