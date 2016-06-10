//
//  ViewController.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/10/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Config.Main.NUMBER_OF_ITEMS_IN_SECTION
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Config.Main.NUMBER_OF_SECTIONS_IN_COLLECTION_VIEW
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView
            .dequeueReusableCellWithReuseIdentifier(Config.Main.CELL_IDENTIFIER, forIndexPath: indexPath) as? PokeCell{
            
            let pokemon = Pokemon(name: "Unknow", pokedexId: indexPath.row)
            cell.configurePokemon(pokemon)
            
            return cell
            
        }else{
            
            return UICollectionViewCell()
        }

        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(110,100)
    }
    

}

