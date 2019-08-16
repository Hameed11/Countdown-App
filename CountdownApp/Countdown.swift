//
//  Countdown.swift
//  CountdownApp
//
//  Created by Hameed Abdullah on 8/9/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import Foundation



//2
struct CountdownDate: Codable {
    
    //1
    let title: String
    let startCountdownDate: Date
    let endCountdownDate: Date
    //2
     //save data somewhere in the app's Documents directory. Since this directory is accessible by your app and can't be modified by another app, it's a safe place to store your list. You can use the FileManager class to locate your app's Documents directory,
//    static let documentdDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    static let archiveURL: URL = documentdDirectory.appendingPathComponent("countdown").appendingPathExtension("plist")
    
    //computed property
    static var archiveURL: URL {
        guard let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("FileManager.default.urls returned an empty array");
        }
        return documentsDirectory.appendingPathComponent("countdown").appendingPathExtension("plist");
    }
    
    //3
    static func saveToFile(countdownDates : [CountdownDate]) {
        
        let propertyListEncoder: PropertyListEncoder = PropertyListEncoder()
        
        guard let codedDates: Data = try? propertyListEncoder.encode(countdownDates) else {
            fatalError("could not encode countdownDates")
        }
        
        if (try? codedDates.write(to: archiveURL, options: .noFileProtection)) == nil {
            fatalError("could not write Data to file \(archiveURL)");
        }
    }
    
    
    //4
    //load data from disk, Use a PropertyListDecoder and the methods on Data
    static func loadDates() -> [CountdownDate]? {
        
        guard let codedDates: Data = try? Data(contentsOf: archiveURL) else {
            return [] //if is doesnt work we retrun an empty array
        }
        
        let propertyListDecoder: PropertyListDecoder = PropertyListDecoder()
        
        guard let countdowns: [CountdownDate] = try? propertyListDecoder.decode([CountdownDate].self, from: codedDates) else {
           fatalError("could not decode Data read from file \(archiveURL)");
        }
        
        return countdowns
        
      }
    
    
    
    static func loadSampleDates() -> [CountdownDate]  {
          let currentDate: Date = Date()
        return [
            CountdownDate(title: "Christmas", startCountdownDate: currentDate, endCountdownDate: currentDate.addingTimeInterval(86400)),
            
            CountdownDate(title: "shit", startCountdownDate: currentDate, endCountdownDate: currentDate.addingTimeInterval(86400))
        ]
    }
    
}
