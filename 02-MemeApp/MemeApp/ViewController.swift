//
//  ViewController.swift
//  MemeApp
//
//  Created by Antonio Sejas on 20/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgChoosed: UIImageView!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var tfTop: UITextField!
    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var tfBottom: UITextField!
    
    //It must be declared as property in the class,
    // because if it is declared inside of viewDidLoad, the object is just temporal
    let textEditDelegate = TextEditDelegate()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextField(tfTop)
        initTextField(tfBottom)
        
        
    }
    
    func initTextField(tf:UITextField){
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -7.0
        ]
        
        tf.defaultTextAttributes = memeTextAttributes
        //The textAlignment must be after set the defaultTextAttributes
        tf.textAlignment = .Center
        tf.delegate = textEditDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        suscribeKeyboardNotification()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //Hide status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: Picker
    @IBAction func actionPickImage(sender: AnyObject) {
        pickImageAux(sender)
    }
    @IBAction func actionPickImageCamera(sender: AnyObject) {
        pickImageAux(sender,fromCamera:true)
    }
    func pickImageAux(sender: AnyObject, fromCamera: Bool = false){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        if (fromCamera){
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info: ",info)
        //UIImagePickerControllerMediaType
        //UIImagePickerControllerOriginalImage
        //UIImagePickerControllerReferenceURL
        //https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImagePickerControllerDelegate_Protocol/index.html#//apple_ref/doc/constant_group/Editing_Information_Keys
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imgChoosed.image = image
        }else{
            print("Error, returnin the image in didFinishPickingMediaWithInfo",info)
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("picker canceled")
    }
    
    //MARK: Share Cancel
    @IBAction func actionShare(sender: AnyObject) {
    }
    @IBAction func actionCancel(sender: AnyObject) {
    }
    
    
    //MARK: Keyboard
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        var height: CGFloat = 0
        if(tfBottom.editing){
            let userInfo = notification.userInfo
            //of CGRect
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            height = keyboardSize.CGRectValue().height
        }
        return height
    }
    func keyboardWillShow(notification: NSNotification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    //Suscribe and Unsuscribe to keyboard to move the view to show the textField at the bottom
    func suscribeKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func save() {
        
        //Create the meme
        let meme = Meme( textTop: tfTop.text!, textBottom: tfBottom.text!, image: imgChoosed.image!, memedImage: imgChoosed.image!)
    }

}

