//
//  ViewController.swift
//  MemeApp
//
//  Created by Antonio Sejas on 20/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var tfTop: UITextField!
    @IBOutlet weak var tfBottom: UITextField!
    @IBOutlet weak var imgChoosed: UIImageView!
    
    //It must be declared as property in the class,
    // because if it is declared inside of viewDidLoad, the object is just temporal
    let textEditDelegate = TextEditDelegate()
    
    var currentFont = 0
    let fonts = ["Impact", "HelveticaNeue-CondensedBlack"]
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        initTextField(tfTop)
        initTextField(tfBottom)
    }
    
    func initTextField(textField:UITextField){
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: fonts[currentFont], size: 40)!,
            NSStrokeWidthAttributeName : -7.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        //The textAlignment must be after set the defaultTextAttributes
        textField.textAlignment = .Center
        textField.delegate = textEditDelegate
        textEditDelegate.resetTextFromTextField(textField)
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
    
    //Cancel Button Action
    @IBAction func actionCancel(sender: AnyObject) {
        initTextField(tfTop)
        initTextField(tfBottom)
        imgChoosed.image = UIImage()
    }
    
    //ChangeFont Action
    @IBAction func actionChangeFont(sender: AnyObject) {
        //We could let choose between al the fonts, but we should fix the stroke as well.
        //fonts = UIFont.familyNames()
        currentFont = (currentFont+1) % fonts.count
        let size: CGFloat = 40
        tfTop.font = UIFont(name: fonts[currentFont] , size: size)
        tfBottom.font = UIFont(name: fonts[currentFont] , size: size)
        
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
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imgChoosed.image = image
            //Enable the share button 
            btnShare.enabled = true
        }else{
            print("Error, while returning imagePicker didFinishPickingMediaWithInfo",info)
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Share Action
    @IBAction func actionShare(sender: AnyObject) {
        //
        let memeImg = generateImage()
        let activityVC = UIActivityViewController(activityItems: [memeImg], applicationActivities: [])
        presentViewController(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if success {
                // user confirmed, save the meme
                self.saveMeme(memeImg)
            }
        }
        
    }
    
    //MARK: Generate and Save Image
    func generateImage() -> UIImage {
        //Hide bars
        navigationBar.hidden = true
        toolbar.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memeImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        //restore visibility bars
        navigationBar.hidden = false
        toolbar.hidden = false

        return memeImg
    }
    
    //
    func saveMeme(memeImage: UIImage) -> Meme {
        //Create the meme
        let meme = Meme( textTop: tfTop.text!, textBottom: tfBottom.text!, img: imgChoosed.image!, memeImg: memeImage)
        return meme
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

}

