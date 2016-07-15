//
//  CharacterViewController.swift
//  LordOfTheRingsAPI
//
//  Created by Jeff Norton on 7/14/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var raceTextField: UITextField!
    @IBOutlet weak var residenceTextField: UITextField!
    
    // MARK: - General

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Action(s)
    
    @IBAction func addCharacterButtonTapped(sender: UIButton) {
        
        guard let name = nameTextField.text
            , race = raceTextField.text
            , residence = residenceTextField.text
        where name.characters.count > 0
            && race.characters.count > 0
            && residence.characters.count > 0
        else { return }
        
        CharacterController.sharedController.addCharacter(name, race: race, residence: residence)
        
        nameTextField.text = ""
        raceTextField.text = ""
        residenceTextField.text = ""
        
        nameTextField.becomeFirstResponder()
        
    }
}
