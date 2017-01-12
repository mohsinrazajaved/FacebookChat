//
//  ChatViewController.swift
//  Facebook Chat
//
//  Created by mohsin raza on 12/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit


class ChatViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout
{

    var myfriend:Friend?
    {
        didSet
        {
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(myfriend!)

//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // Do any additional setup after loading the view.
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    

}
