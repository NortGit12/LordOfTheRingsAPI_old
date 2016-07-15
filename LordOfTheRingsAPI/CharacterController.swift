//
//  CharacterController.swift
//  LordOfTheRingsAPI
//
//  Created by Jeff Norton on 7/14/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class CharacterController {
    
    // MARK: - Stored Properties
    
    static let sharedController = CharacterController()
    
    static let baseURL = NSURL(string: "https://jeffnortonapidesign.firebaseio.com/api/lotr/characters/")
    
    static let getterEndpoint = baseURL?.URLByAppendingPathExtension("json")
    
    weak var delegate: CharacterDelegate?
    
    var characters: [Character] {
        
        didSet {
            
            self.delegate?.charactersUpdated(characters)
            
        }
        
    }
    
    // MARK: - Initializer(s)
    
    init() {
        
        self.characters = []
        
        self.getCharacters{ (characters) in
            
            if let characters = characters {
                
                self.characters = characters
                
            }
            
        }
        
    }
    
    // MARK: - Method(s)
    
    static func addCharacter(name: String, race: String, residence: String) {
        
        let character = Character(name: name, race: race, residence: residence)
        
        guard let unwrappedPostURL = character.putEndpoint else { return }
        
        NetworkController.performRequestForURL(unwrappedPostURL, httpMethod: .Put, body: character.jsonData) { (data, error) in
            
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            
            print("responseDataString = \(responseDataString)")
            
            if error != nil {
                
                print("Error (instance): \(error)")
                
            } else if responseDataString.containsString("error") {
                
                print("Error (in message): \(responseDataString)")
                
            } else {
                
                print("Added character successfully")
                
            }
            
        }
        
        CharacterController.getCharacters{ (characters) in
            
            if let characters = characters {
                
                self.characters = characters
                
            }
        }
    }
    
    func getCharacters(completion: ((characters: [Character]?) -> Void)? = nil) {
        
        guard let unwrappedGetURL = CharacterController.getterEndpoint else {
            
            if let completion = completion {
                
                print("Unable to obtain the getter URL")
                completion(characters: nil)
                
            }
            
            return
            
        }
        
        NetworkController.performRequestForURL(unwrappedGetURL, httpMethod: .Get) { (data, error) in
            
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            
            if error != nil {
                
                print("Error (instance): \(error)")
                
                if let completion = completion {
                    
                    completion(characters: nil)
                    
                }
                
                return
                
            } else if responseDataString.containsString("errro") {
                
                print("Error (in message): \(responseDataString)")
                
                if let completion = completion {
                    
                    completion(characters: nil)
                    
                }
                
            } else {
                
                print("Got the characters successfully")
                
            }
            
//            print("\ndata (wrapped) = \(data)")
            
            guard let data = data
                , mainCharacterDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : [String : AnyObject]]
            else {
                
                print("Data could not be accessed during get")
                
                if let completion = completion {
                    
                    completion(characters: nil)
                    
                }
                
                return
                
            }
            
//            print("\ndata (unwrapped) = \(data)")
            
            print("\nmainCharacterDictionary = \(mainCharacterDictionary)")

            let charactersArray = mainCharacterDictionary.flatMap{ Character(identifier: $0.0, dictionary: $0.1) }
            
            print("\ncharactersArray = \(charactersArray)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if let completion = completion {
                    
                    self.characters = charactersArray
                    completion(characters: charactersArray)
                    
                }
                
                return
            })
        }
    }
    
}

protocol CharacterDelegate: class {
    
    func charactersUpdated(characters: [Character])
    
}