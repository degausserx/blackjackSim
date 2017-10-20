//
//  Settings.swift
//  BlackjackSimulator
//
//  Created by Admin on 05/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class Settings: NSObject, NSCoding {
    
    static var instance: Settings = Settings()
    
    var player: Player = Player()
    var house: House = House()
    var execution: Execution = Execution()
    var title: String = "Untitled" {
        didSet {
            self.reloadExecution = true
            self.reloadHouse = true
            self.reloadPlayer = true
        }
    }
    var appDirectory = ""
    var reloadPlayer = false
    var reloadHouse = false
    var reloadExecution = false
    
    private override init() {
        super.init()
        self.appDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.player = aDecoder.decodeObject(forKey: "conPlayer") as! Player
        self.house = aDecoder.decodeObject(forKey: "conHouse") as! House
        self.execution = aDecoder.decodeObject(forKey: "conExecution") as! Execution
        self.title = aDecoder.decodeObject(forKey: "conTitle") as! String
    }
    
    func encode(with: NSCoder) {
        with.encode(self.player, forKey: "conPlayer")
        with.encode(self.house, forKey: "conHouse")
        with.encode(self.execution, forKey: "conExecution")
        with.encode(self.title, forKey: "conTitle")
    }
    
}

extension Settings {

    func save() -> Bool {
        
        if (self.title == "" || self.title == "Untitled") {
            return false
        }
        let fileURL = (self.appDirectory as NSString).appendingPathComponent("\(self.title).dat")
        NSKeyedArchiver.archiveRootObject(Settings.instance, toFile: fileURL)
        return true
    }
    
    func saveAs(value: String) -> Bool {
        self.title = value
        return self.save()
    }
    
    func delete(value: String) -> Bool {
        let realFileManager = FileManager.default
        if let fileManager = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let fileURL = (fileManager as NSString).appendingPathComponent("\(value).dat")
            do {
                try realFileManager.removeItem(atPath: fileURL)
            } catch {
                return false
            }
            return true
        }
        return false
    }

    func load(value: String) -> Bool {
        let fileDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileURL = (fileDir! as NSString).appendingPathComponent("\(value).dat")
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL) as! Settings? {
            self.house = data.house
            self.execution = data.execution
            self.player = data.player
            self.title = data.title
            return true
        }
        return false
    }
    
    func list() -> [String] {
        do {
            let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let directoryContents = try FileManager.default.contentsOfDirectory(at: fileManager, includingPropertiesForKeys: nil, options: [])
            let SettingsFiles = directoryContents.filter{ $0.pathExtension == "dat" }
            let FileNames = SettingsFiles.map{ $0.deletingPathExtension().lastPathComponent }
            return FileNames
        }
        catch {
            return []
        }
    }
    
}
