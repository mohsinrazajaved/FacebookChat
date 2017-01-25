//
//  ChatViewController.swift
//  Facebook Chat
//
//  Created by mohsin raza on 12/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import  CoreData

class ChatVC: UIViewController
{
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageBox: UIView!
    @IBOutlet weak var messageBoxBottomLayout: NSLayoutConstraint!
    var _fetchedResultsController: NSFetchedResultsController<Message>?
    var myfriend:Friend?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = myfriend?.friendName
        self.friendname = myfriend?.friendName
    }
    
    //Mark: NSFetchResultController
    
   private var friendname:String?
    {
        didSet
        {
            
            let fetchRequest:NSFetchRequest<Message> = Message.fetchRequest()
            fetchRequest.predicate = NSPredicate(format:"toFriend.friendName = %@",friendname!)
            let sortDescriptor = NSSortDescriptor(key:"msgTime", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DatabaseController.getContext(), sectionNameKeyPath: nil, cacheName: nil)
            
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            do
            {
                try _fetchedResultsController!.performFetch()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
           self.collectionView.reloadData()
     }}

    
    @IBAction func backBtn(_ sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMsg(_ sender: UIButton)
    {
        if let text = textField.text
        {
            FriendsVC.textmessages(messg: text, minutes:1, friend:myfriend!,optional:true)
        }
        
        textField.text = nil
    }
    
}


extension ChatVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self._fetchedResultsController!.sections?.count ?? 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        let sectionInfo = self._fetchedResultsController!.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"chat", for: indexPath)
        if let mycell = cell as? chatViewCell
        {
            mycell.recevingwidth = view.frame.width
            let msg = self._fetchedResultsController!.object(at: indexPath)
            mycell.chatmessage = msg
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //Hight of each item is calculated in a collectionview according to the size of the text
        if let messagetext =  self._fetchedResultsController!.object(at: indexPath).msgText
        {
            let size = CGSize(width:250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messagetext).boundingRect(with: size, options: options, attributes: nil, context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
            
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
}


extension ChatVC:NSFetchedResultsControllerDelegate
{
    //Mark: NSFetchResultController
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        if type == .insert
        {
            collectionView.insertItems(at: [newIndexPath!])
            self.collectionView.scrollToItem(at: newIndexPath!, at: .bottom, animated: true)
        }
    }
}


extension ChatVC:UITextFieldDelegate
{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}



