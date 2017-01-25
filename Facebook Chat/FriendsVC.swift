//
//  FriendsViewController.swift
//  Facebook Chat
//
//  Created by mohsin raza on 11/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import CoreData

class FriendsVC:UIViewController,NSFetchedResultsControllerDelegate
{
   
    @IBOutlet weak var tableView: UITableView!
    var _fetchedResultsController: NSFetchedResultsController<Friend>?
    override func viewDidLoad()
    {
      super.viewDidLoad()
      setupData()
      start = "fetch"
    }
    
    
    //Mark: NSFetchResultController
    
       fileprivate var start:String?
       {
        
        didSet
        {
            
            let fetchRequest:NSFetchRequest<Friend> = Friend.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key:"lastmessage.msgTime", ascending: false)]
            fetchRequest.predicate = NSPredicate(format:"lastmessage != nil")
            
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
            
            //self.tableView.reloadData()
        }}

    
    
    //Mark: NSFetchResultControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        if type == .insert
        {
          tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }

     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
     
        if segue.identifier  == Storyboard.Reuseidentifier2
        {
        
            if let destinationvc = segue.destination as? ChatVC
            {
                if let buddy = sender as? Friend
                {
                  destinationvc.myfriend = buddy
                }
            }
        }
    }
    
    fileprivate struct Storyboard
    {
        static let Reuseidentifier1 = "cell"
        static let Reuseidentifier2 = "default"
    }
}


extension FriendsVC:UITableViewDelegate,UITableViewDataSource
{
    
    // MARK: UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let sectionInfo = self._fetchedResultsController!.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.Reuseidentifier1, for: indexPath)
        
        if let newcell = cell as? FriendViewCell
        {
            newcell.message = _fetchedResultsController?.object(at: indexPath).lastmessage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier:Storyboard.Reuseidentifier2, sender: _fetchedResultsController?.object(at: indexPath))
    }
}


