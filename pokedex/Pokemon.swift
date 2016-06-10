//
//  Pokemon.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/10/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name:String!
    private var _pokedexId:Int!
    
    var name:String{ get{ return self._name }}
    var pokedexId:Int{
        get{
            return self._pokedexId + 1
        }
    }
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}