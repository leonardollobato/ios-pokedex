//
//  ViewController.swift
//  pokedex
//
//  Created by Leonardo Lobato on 6/10/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var playButton:UIButton!
    
    private var pokemoCollection = [Pokemon]();
    private var musicPlayer:AVAudioPlayer!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let audioFile = NSBundle.mainBundle().pathForResource(Config.Main.Resource.SONG_FILENAME, ofType: Config.Main.Resource.SONG_TYPE)!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string:audioFile)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.25
            musicPlayer.play()
            
        }catch let error as NSError{
            print(error.description)
        }
    }
    
    func parsePokemonCSV(){
        let csvFile = NSBundle.mainBundle().pathForResource(Config.Main.Resource.IMPORT_FILENAME, ofType: Config.Main.Resource.IMPORT_TYPE)!
        
        do {
            let content = try CSVParser(contentsOfURL: csvFile)
            let rows = content.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemoCollection.append(poke)
                
            }
            
        }catch let error as NSError{
            print(error.description)
        }
        
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
            
            let pokemon = pokemoCollection[indexPath.row]
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
    
    @IBAction func setAudio(sender: AnyObject) {
        
        var playerImage = Config.Main.MUSIC_PLAYING_IMAGE
        
        if musicPlayer.playing {
            musicPlayer.stop()
            playerImage = Config.Main.MUSIC_STOP_IMAGE
            
        }else{
            musicPlayer.play()
            playerImage = Config.Main.MUSIC_PLAYING_IMAGE
        }
        
        playButton.setImage(UIImage(named:playerImage), forState: .Normal)
    }

}

