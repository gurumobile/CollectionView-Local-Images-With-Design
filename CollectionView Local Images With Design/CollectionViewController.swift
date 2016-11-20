//
//  CollectionViewController.swift
//  CollectionView Local Images With Design
//
//  Created by Abdullah on 11/18/16.
//  Copyright © 2016 CombitSolutions. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseCell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var picturesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // populate picturesArray from pictures' folder contents by looping not adding images manually
        picturesArray = onAddImages()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.myImage.image = UIImage(named: picturesArray[indexPath.row])
        
        return cell
    }

    
    
    // === LAYOUT === //
    
    // cell size + if any margins
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rightAndLeftPaddings : CGFloat = 10  // paddings
        let screenWidthSize = self.view.bounds.width; // screen width
        let cellSize = (screenWidthSize / 3) - rightAndLeftPaddings  // three items per row
        
        return CGSize(width: cellSize, height: cellSize)
    }

    // vertical line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // CollectionView Insets/paddings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return insets;
    }
    
    func onAddImages() -> [String] {
        let path = Bundle.main.resourcePath!
        let fm = FileManager.default
        var returnArray = [String]()
        
        if let directoryAndFileNames = try? fm.contentsOfDirectory(atPath: path) {
            let results = directoryAndFileNames.filter({ (filename) -> Bool in
                let index = filename.index(filename.endIndex, offsetBy: -5)
                let ext = filename.substring(from: index)
                if ext.contains("jpg") {
                    return true
                }
                else {
                    return false
                }
            })
            print(results)
            
            returnArray = results
        }
        else {
            print("empty")
            
        }
        return returnArray
    }
}
