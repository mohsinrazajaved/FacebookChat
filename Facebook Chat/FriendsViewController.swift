//
//  FriendsViewController.swift
//  Facebook Chat
//
//  Created by mohsin raza on 11/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import CoreData

class FriendsViewController:UIViewController,UITableViewDelegate,UITableViewDataSource
{
   
    @IBOutlet weak var tableView: UITableView!
    var messages:[Message]?
    override func viewDidLoad()
    {
      super.viewDidLoad()
      //createData()
     // clearData = "clear"
      messages = [Message]()
      fetchData()
    }
    
    private var clearData:String?
    {
       didSet
       {
    
        let fetchrequest:NSFetchRequest<Message> = Message.fetchRequest()
            
        do
        {
            
            messages = try  DatabaseController.getContext().fetch(fetchrequest)
            for f in messages!
            {
               DatabaseController.getContext().delete(f)
               DatabaseController.saveContext()
            }
        }
        catch let error
        {
            print("\(error)")
        }
        
        let fetchrequest1:NSFetchRequest<Friend> = Friend.fetchRequest()
        
        do
        {
            
            for f in try  DatabaseController.getContext().fetch(fetchrequest1)
            {
                DatabaseController.getContext().delete(f)
                DatabaseController.saveContext()
            }
        }
        catch let error
        {
            print("\(error)")
        }

        
       }
    }
    
    
    // MARK: CoreDataFetching
    
    private func createData()
    {
//        let friend1 = Friend(context: DatabaseController.getContext())
//        friend1.friendName = "Steve Jobs"
//        let img1 = UIImage(named: "1.jpg")
//        friend1.profileImage = UIImage(data:UIImageJPEGRepresentation(img1!, 0.3)!)
//        textmessages(messg: "Welcome to apple bro",minutes: 1, friend: friend1)
//        textmessages(messg: "Welcome to apple bro again",minutes: 0,friend: friend1)
//        
//        let friend2 = Friend(context: DatabaseController.getContext())
//        friend2.friendName = "Larry Ellison"
//        let img2 = UIImage(named: "2.jpg")
//        friend2.profileImage = UIImage(data:UIImageJPEGRepresentation(img2!, 0.3)!)
//        textmessages(messg: "Welcome to java",minutes: 6,friend: friend2)
//
//        
//        let friend3 = Friend(context: DatabaseController.getContext())
//        friend3.friendName = "Mark Zuckerberg"
//        let img3 = UIImage(named: "5.jpg")
//        friend3.profileImage = UIImage(data:UIImageJPEGRepresentation(img3!, 0.3)!)
//        textmessages(messg: "Welcome to facebook",minutes: 9,friend: friend3)
//        
    }
    
    //creating an nsmanagedobject of messages
    private func textmessages(messg:String,minutes:Double,friend:Friend)
    {
        let msg = Message(context: DatabaseController.getContext())
        msg.msgText = messg
        msg.msgTime = NSDate().addingTimeInterval(-minutes * 60.0)
        msg.toFriend = friend
        DatabaseController.saveContext()
    }

    
    private func fetchData()
    {
        if let fetch = fetchFriends()
        {
        
        messages = [Message]()
        for f in fetch
        {
            
        let fetchRequest:NSFetchRequest<Message> = Message.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "msgTime", ascending: false)]
        fetchRequest.predicate = NSPredicate(format:"toFriend.friendName = %@",f.friendName!)
        fetchRequest.fetchLimit = 1
        
        do
        {
            //populating my array friend with the fetched data
             messages?.append((try  DatabaseController.getContext().fetch(fetchRequest).first!))
             messages?.sort(by: {$0.msgTime!.compare($1.msgTime! as Date) == ComparisonResult.orderedDescending })

        }
        catch let error
        {
          print("\(error)")
        }
       }
     }
   }
    
    private func fetchFriends()->[Friend]?
    {
    
        let fetchRequest:NSFetchRequest<Friend> = Friend.fetchRequest()
        
        do
        {
            return try  DatabaseController.getContext().fetch(fetchRequest)
        }
        catch let error
        {
            print("\(error)")
        }
        
        return nil
    }

    
    // MARK: UITableViewDataSource

    
    func numberOfSections(in tableView: UITableView) -> Int
    {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (messages != nil) ? messages!.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ReuseIdentifier, for: indexPath)
        
        if let newcell = cell as? FriendViewCell
        {
           newcell.message =  messages![indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       performSegue(withIdentifier: "default", sender: messages?[indexPath.row])
    }
    
    
    // MARK: UITableViewDelegate
    
    private struct Storyboard
    {
       static let ReuseIdentifier = "cell"
    }
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
     
        if segue.identifier  == "default"
        {
        
            if let destinationvc = segue.destination as? ChatViewController
            {
                if let buddy = sender as? Message
                {
                  destinationvc.myfriend = buddy.toFriend
                }
            }
        }
    }
}
