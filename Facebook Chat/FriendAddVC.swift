//
//  ItemViewController.swift
//  DreamListener
//
//  Created by mohsin raza on 09/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import CoreData

class FriendAddVC: UIViewController
{
    
    let picker = UIImagePickerController()
    @IBOutlet weak var friendImage: UIButton!
    @IBOutlet weak var friendName: UITextField!
    @IBOutlet weak var friendEmail: UITextField!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         picker.delegate = self
    }
    

    //Mark: Item Operations
    
    @IBAction func itemDelete(_ sender: UIBarButtonItem)
    {
//        DatabaseController.getContext().delete()
//        DatabaseController.saveContext()
    }
    
    @IBAction func itemSubmit(_ sender: UIButton)
    {
        guard let name = friendName.text,let msg = friendEmail.text
        else {return}
        
        let friend5 = Friend(context: DatabaseController.getContext())
        friend5.friendName = name
        let img5 = UIImage(data:UIImageJPEGRepresentation((friendImage.imageView?.image)!, 0.3)!)
        
        friend5.profileImage = UIImage(data:UIImageJPEGRepresentation(img5!, 0.3)!)
        FriendsVC.textmessages(messg:msg,minutes:8 * 60 * 24 ,friend: friend5)
        
        DatabaseController.saveContext()
      _ = navigationController?.popViewController(animated: true)
        
     }
    
    
    @IBAction func backtorecents(_ sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }
}


extension FriendAddVC:UIImagePickerControllerDelegate
{
    //Mark: Imagepicker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        friendImage.setImage(chosenImage, for:.normal)
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton)
    {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }

}


extension FriendAddVC:UINavigationControllerDelegate
{
    //Mark: NavigationBar
    
    func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
}



