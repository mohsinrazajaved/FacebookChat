//
//  chatViewCell.swift
//  Facebook Chat
//
//  Created by mohsin raza on 13/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit

class chatViewCell: UICollectionViewCell
{
    var recevingwidth:CGFloat!
    var chatmessage:Message?
    {
      didSet
      {
        updateUI()
      }
    }

    @IBOutlet weak var chatMsg: UITextView!
    @IBOutlet weak var msgTextView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    
    private func updateUI()
    {
     
        let size = CGSize(width:250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: (chatmessage?.msgText)!).boundingRect(with: size, options: options, attributes:nil, context: nil)
        let recevingorsending = chatmessage?.isSender
        
      if recevingorsending == true
      {
         chatMsg.frame = CGRect(x: recevingwidth - estimatedFrame.width - 16 - 10, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
         msgTextView.frame = CGRect(x: recevingwidth - estimatedFrame.width - 16 - 8 - 10, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
        

         userImage.isHidden = true
         chatMsg.text = chatmessage?.msgText
         chatMsg.textColor = .white
         msgTextView.layer.cornerRadius = 15
         msgTextView.layer.masksToBounds = true
      }
        
      else
      {
        
        chatMsg.frame = CGRect(x:37 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        msgTextView.frame = CGRect(x: 37, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
        
        userImage.isHidden = false
        msgTextView.layer.cornerRadius = 15
        chatMsg.text = chatmessage?.msgText
        msgTextView.layer.masksToBounds = true
        msgTextView.backgroundColor = .lightGray
        userImage.image = chatmessage?.toFriend?.profileImage as! UIImage?
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true

      }
        
       
    }
}

