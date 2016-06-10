//
//  Config.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/10/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import Foundation
import CoreGraphics

class Config {
    struct Main{
            static var NUMBER_OF_SECTIONS_IN_COLLECTION_VIEW = 1
            static var NUMBER_OF_ITEMS_IN_SECTION = 718
            static var CELL_IDENTIFIER = "PokeCell"
            static var CELL_CORNER_RADIUS = CGFloat(10.0)
            static var MUSIC_PLAYING_IMAGE = "speakerOn"
            static var MUSIC_STOP_IMAGE = "speakerOff"
        
        struct Resource{
            static var IMPORT_FILENAME = "pokemon"
            static var IMPORT_TYPE = "csv"
            static var SONG_FILENAME = "music"
            static var SONG_TYPE = "mp3"
        }
    }
}
