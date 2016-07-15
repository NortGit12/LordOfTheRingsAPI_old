//
//  CharactersTableViewController.swift
//  LordOfTheRingsAPI
//
//  Created by Jeff Norton on 7/14/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController, CharacterDelegate {

    // MARK: - Stored Properties
    
    var characterController = CharacterController()
    
    // MARK: - General
    
    override func viewDidLoad() {
        
        characterController.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return characterController.characters.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("characterCell", forIndexPath: indexPath)

        let character = characterController.characters[indexPath.row]
        
        cell.textLabel?.text = character.name
        
        cell.detailTextLabel?.text = character.race

        return cell
    }


    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    // MARK: - CharacterDelegate
    
    func charactersUpdated(characters: [Character]) {
        
        tableView.reloadData()
        
    }

}
