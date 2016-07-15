//
//  Character.swift
//  LordOfTheRingsAPI
//
//  Created by Jeff Norton on 7/14/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class Character {
    
    // MARK: - Stored Properties
    
    let identifier: NSUUID
    let name: String
    let race: String
    let residence: String
    
    private let kIdentifier = "identifier"
    private let kName = "name"
    private let kRace = "race"
    private let kResidence = "residence"
    
    var putEndpoint: NSURL? {
        
        return CharacterController.baseURL?
            .URLByAppendingPathComponent("\(identifier.UUIDString)")
            .URLByAppendingPathExtension("json")
        
    }
    
    var dictionaryValue: [String : AnyObject] {
        
        return [kName: name, kRace: race, kResidence: residence]
        
    }
    
    var jsonData: NSData? {
        
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryValue, options: .PrettyPrinted)
        
    }
    
    var descriptionString: String {
        
        return "\(kIdentifier) = \(identifier.UUIDString), \(kName) = \(name), \(kRace) = \(race), \(kResidence) = \(residence)"
        
    }
    
    // MARK: - Initializer(s)
    
    init(name: String, race: String, residence: String) {
        
        self.identifier = NSUUID()
        self.name = name
        self.race = race
        self.residence = residence
        
    }
    
    init?(identifier: String, dictionary: [String : AnyObject]) {
        
        guard let identifier = NSUUID(UUIDString: identifier)
            , name = dictionary[kName] as? String
            , race = dictionary[kRace] as? String
            , residence = dictionary[kResidence] as? String
        else { return nil }
        
        self.identifier = identifier
        self.name = name
        self.race = race
        self.residence = residence
        
    }
    
}