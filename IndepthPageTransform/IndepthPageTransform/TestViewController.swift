
    //  Created by Anish on 2/22/16.
    //  Copyright © 2016 AnishParajuli. All rights reserved.

    import UIKit
    import Foundation
    
    class TestViewController: UIViewController{
        //MARK:-Outlet

        @IBOutlet weak var collectionView: UICollectionView!
        
        
        //MARK:-Variable
        var index :Int = 0

        
        //MARK:-VIEW LIFE CYCLES
        override func viewDidLoad() {
            super.viewDidLoad()
            self.collectionView.dataSource = self
            
        }
      
       
    
    }
    extension TestViewController: UICollectionViewDataSource{
        //MARK:-CollectionView DataSource and Delegate
        
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
            return 6
            
        }
        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
            cell.backgroundColor = UIColor(red: CGFloat((arc4random()%255))/255.0, green: CGFloat((arc4random()%255))/255.0, blue: CGFloat((arc4random()%255))/255.0, alpha: 1)
            cell.layer.cornerRadius = 12
            return cell
        }
        
    }