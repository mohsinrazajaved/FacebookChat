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

        if let cellmsg = message
        {
        
        userName.text = cellmsg.toFriend?.friendName
        recentMsg.text = cellmsg.msgText
       
        //date formater to format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        let elapsedTimeInSeconds = NSDate().timeIntervalSince(cellmsg.msgTime as! Date)
        
            let secondInDays:TimeInterval = 60 * 60 * 24
        
            if elapsedTimeInSeconds > 7 * secondInDays
            {
                formatter.dateFormat = "MM/dd/yy"
            }
            else if elapsedTimeInSeconds > secondInDays
            {
              formatter.dateFormat = "EEE"
            }
        
            
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
    

