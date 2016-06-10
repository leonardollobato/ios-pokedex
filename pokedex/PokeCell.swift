//
//  PokeCell.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/10/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    
    //private var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set Cell Border Radius
        self.layer.cornerRadius = Config.Main.CELL_CORNER_RADIUS
    }
    
    func configurePokemon(pokemon:Pokemon) {
        
        //self.pokemon = pokemon
        self.thumbImage.image = UIImage(named: "\(pokemon.pokedexId)")
        self.nameLabel.text = pokemon.name.capitalizedString
    }
}
