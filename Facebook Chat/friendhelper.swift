//
//  friendhelper.swift
//  Facebook Chat
//
//  Created by mohsin raza on 15/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import CoreData

extension FriendsVC
{
    
    func clearData()
    {
        
        let entityNames = ["Friend", "Message"]
                
        for entityName in entityNames
        {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do
        {
           let objects = try(DatabaseController.getContext().fetch(fetchRequest))
              for object in objects
              {
                DatabaseController.getContext().delete(object as! NSManagedObject)
              }
        }
        catch let error as NSError
        {
          print(error.debugDescription)
        }
      }
    }
    
    func setupData()
    {
        
        clearData()

    
        let friend1 = Friend(context: DatabaseController.getContext())
        friend1.friendName = "Steve Jobs"
        let img1 = UIImage(named: "1.jpg")
        friend1.profileImage = UIImage(data:UIImageJPEGRepresentation(img1!, 0.3)!)
        FriendsVC.textmessages(messg: "Good morning..",minutes: 3, friend: friend1)
        FriendsVC.textmessages(messg: "Hello, how are you? Hope you are having a good morning!",minutes: 2, friend: friend1)
        FriendsVC.textmessages(messg:"Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs.  Please make your purchase with us.",minutes: 1, friend: friend1)
        FriendsVC.textmessages(messg: "Want to show you the new smart phone of the decades",minutes: 1, friend: friend1)
        FriendsVC.textmessages(messg:"Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs.  Please make your purchase with us.",minutes: 1, friend: friend1)
        FriendsVC.textmessages(messg: "Want to show you the new smart phone of the decades",minutes: 8 * 60 * 24, friend: friend1)
        FriendsVC.textmessages(messg:"Totally understand that you want the new iPhone 7, but you'll have to wait until September for the new release. Sorry but thats just how Apple likes to do things.",minutes: 1, friend: friend1)
        FriendsVC.textmessages(messg: "Absolutely, I'll just use my gigantic iPhone 6 Plus until then!!!",minutes: 6 * 60 * 24, friend: friend1,optional:true)
        
        let friend2 = Friend(context: DatabaseController.getContext())
        friend2.friendName = "Mark Zakerburg"
        let img2 = UIImage(named: "5.jpg")
        friend2.profileImage = UIImage(data:UIImageJPEGRepresentation(img2!, 0.3)!)
        FriendsVC.textmessages(messg: "facebook is live now lets chats togather",minutes: 60 * 24,friend: friend2)
        FriendsVC.textmessages(messg: "Please use facebook is good",minutes: 60 * 12,friend: friend2,optional:true)
        
        let friend3 = Friend(context: DatabaseController.getContext())
        friend3.friendName = "Donald Trump"
        let img3 = UIImage(named: "donald_trump_profile.jpg")
        friend3.profileImage = UIImage(data:UIImageJPEGRepresentation(img3!, 0.3)!)
        FriendsVC.textmessages(messg:"You're fired",minutes:5 ,friend: friend3)

        let friend4 = Friend(context: DatabaseController.getContext())
        friend4.friendName = "Larry Ellsion"
        let img4 = UIImage(named: "2.jpg")
        friend4.profileImage = UIImage(data:UIImageJPEGRepresentation(img4!, 0.3)!)
        FriendsVC.textmessages(messg: "Jave is good programming language",minutes: 6 * 24,friend: friend4)
    
        let friend5 = Friend(context: DatabaseController.getContext())
        friend5.friendName = "Hillary Clinton"
        let img5 = UIImage(named: "hillary_profile.jpg")
        friend5.profileImage = UIImage(data:UIImageJPEGRepresentation(img5!, 0.3)!)
        FriendsVC.textmessages(messg:"Please vote for me, you did for Billy!",minutes:8 * 60 * 24 ,friend: friend5)
        
        DatabaseController.saveContext()
    }
    
    class func textmessages(messg:String,minutes:Double,friend:Friend,optional:Bool = false)
    {
        let msg = Message(context: DatabaseController.getContext())
        msg.msgText = messg
        msg.msgTime = NSDate().addingTimeInterval(-minutes * 60.0)
        msg.toFriend = friend
        msg.isSender = NSNumber(value: optional) as Bool
        friend.lastmessage = msg
    }
    

}

