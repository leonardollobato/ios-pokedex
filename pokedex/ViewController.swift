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
                            UICollectionViewDelegateFlowLayout,
                            UISearchBarDelegate{
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var playButton:UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    private var pokemonCollection = [Pokemon]()
    private var musicPlayer:AVAudioPlayer!;
    
    private var filteredPokemons = [Pokemon]()
    private var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.Done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let audioFile = NSBundle.mainBundle().pathForResource(Config.Main.Resource.SONG_FILENAME, ofType: Config.Main.Resource.SONG_TYPE)!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string:audioFile)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.50
            musicPlayer.stop()
            
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
                pokemonCollection.append(poke)
                
            }
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemons.count : pokemonCollection.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Config.Main.NUMBER_OF_SECTIONS_IN_COLLECTION_VIEW
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView
            .dequeueReusableCellWithReuseIdentifier(Config.Main.CELL_IDENTIFIER, forIndexPath: indexPath) as? PokeCell{
            
            let pokemon = inSearchMode ? filteredPokemons[indexPath.row] : pokemonCollection[indexPath.row]
            cell.configurePokemon(pokemon)
            
            return cell
            
        }else{
            
            return UICollectionViewCell()
        }

        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke:Pokemon
        
        if inSearchMode {
            poke = filteredPokemons[indexPath.row]
        }else{
            poke = pokemonCollection[indexPath.row]
        }
        
        performSegueWithIdentifier(Config.Main.Segue.POKEMON_DETAIL, sender: poke)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Config.Main.Segue.POKEMON_DETAIL {
            if let pokemonDetailsVC = segue.destinationViewController as?
                PokemonDetailViewController{
                if let pokemon =  sender as? Pokemon{
                    pokemonDetailsVC.pokemon = pokemon
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(110,100)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil{
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            
            inSearchMode = true
            let lowerCaseTerm = searchBar.text!.lowercaseString
            filteredPokemons = pokemonCollection.filter({ (pokemon:Pokemon) -> Bool in
                pokemon.name.rangeOfString(lowerCaseTerm) != nil
            })

            collectionView.reloadData()
        }
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

