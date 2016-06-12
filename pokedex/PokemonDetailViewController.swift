//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/12/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemon:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(pokemon.name)
    }
}
