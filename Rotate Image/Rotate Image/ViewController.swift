//
//  ViewController.swift
//  Rotate Image
//
//  Created by Muhammad Hilmy Fauzi on 23/10/17.
//  Copyright © 2017 Hilmy Corp. All rights reserved.
//

import UIKit
import MobileCoreServices
//akses library
import AssetsLibrary

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgPreview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func btnRotate(_ sender: Any) {
        //menambahkan durasi animasi
        //durasi rotasi nya 2 detik
        //dan angle rotasinya 180 derajat
        UIView.animate(withDuration: 2.0, animations: {
            self.imgPreview.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        })
    }
    @IBAction func btnsave(_ sender: Any) {
        //mengecek apakah gambarnya kosong
        if imgPreview.image == nil {
            let alert = UIAlertView(title: "Warning", message: "Please Input the Image", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }else{
            //kondisi ketika tidak kosong
            //simpan image
            let imgData = UIImageJPEGRepresentation(imgPreview.image!, 1.0)
            //deklarasi kompres image
            let compressJPEG = UIImage(data: imgData!)
            
            //menyimpan gambar ke album photo
            UIImageWriteToSavedPhotosAlbum(compressJPEG!, nil, nil, nil)
            
            //muncul alert ketika berhasil disimpan
            let alert = UIAlertView(title: "Success", message: "Your Image edited has been saved", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //deklarasi picker image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //memanggil method customFunction
            costumFunction(image : pickedImage)
        }
        //method nya selesai dan akan menghilang secar otomatis
        dismiss(animated: true, completion: nil)
        
    }
    
    //method baru dengan nama method costumFunction
    func costumFunction(image: UIImage){
        imgPreview.image = image
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //method finish dan gambar tidak jadi di pilih
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnBrowseImage(_ sender: Any) {
        //akses library foto
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //deklarasi imgPicker sebagai objek dari UIImagePickerController
            let imgPicker = UIImagePickerController()
            //menambahkan delegate pada imgPicker
            imgPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            //mengature type source nya adalah photolibrary
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //mengatur imgPicker nya biar biasa d edit
            imgPicker.allowsEditing = true
            self.present(imgPicker,animated: true,completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
