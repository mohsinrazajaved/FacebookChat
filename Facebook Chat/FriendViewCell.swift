//
//  FriendViewCell.swift
//  Facebook Chat
//
//  Created by mohsin raza on 11/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import CoreData

class FriendViewCell: UITableViewCell
{
    var unique:String?
    
    var message:Message?
    {
       didSet
       {
          updateUI()
       }
    }
    
    // MARK: IBOutlets Of Cell
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var recentMsg: UILabel!
    @IBOutlet weak var smalllpic: UIImageView!
    @IBOutlet weak var userTime: UILabel!
    
    
    func updateUI()
    {

        userImage.image = nil
        smalllpic.image = nil
        userName.text = nil
        recentMsg.text = nil
        
        
        if let cellmsg = message
        {
        
        userName.text = cellmsg.toFriend?.friendName
        recentMsg.text = cellmsg.msgText
       
        //date formater to format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        userTime.text = formatter.string(from:cellmsg.msgTime as! Date)
        userImage.image = cellmsg.toFriend?.profileImage as! UIImage?
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
            
        smalllpic.image = cellmsg.toFriend?.profileImage as! UIImage?
        smalllpic.layer.cornerRadius = smalllpic.frame.size.width / 2
        smalllpic.clipsToBounds = true
            
        }
      }
  }
    

