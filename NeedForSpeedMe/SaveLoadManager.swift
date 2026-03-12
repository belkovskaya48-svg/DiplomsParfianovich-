import Foundation
import UIKit

enum Keys: String {

    case settingsUser
    case imageName
    case recordsKey
}

final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
 
    func saveSettings(_ setting: SettingsClass) {
        
        UserDefaults.standard.set(encodable: setting, forKey: Keys.settingsUser.rawValue)
    }
    
    func loadSettings() -> SettingsClass {

        UserDefaults.standard.get(decodableType: SettingsClass.self, forKey: Keys.settingsUser.rawValue) ?? SettingsClass(userName: "Player", blockName: "куст1", carName: "машинка")
    }
  
    func saveRecords (_ records: [RecordClass])  {
        UserDefaults.standard.set(encodable: records, forKey: Keys.recordsKey.rawValue)
    }
    func loadRecords() -> [RecordClass] {
        UserDefaults.standard.get(decodableType: [RecordClass].self, forKey: Keys.recordsKey.rawValue) ?? []
    }
    
    func saveImage (image: UIImage) -> String? {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return nil}
        
        let filename = UUID().uuidString
        let fileURL = directory.appendingPathComponent(filename)
        guard let data = image.pngData() else {return nil}
     
        do {
            try data.write(to : fileURL)
            return filename
        } catch let error {
           
            print (error.localizedDescription)
            return nil
        }
        }
   
    func loadImage (name: String) -> UIImage? {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
 
        let fileURL = directory.appendingPathComponent(name)
        return UIImage (contentsOfFile: fileURL.path)
        
    }
    
    func saveImageName(_ text: String) {

        defaults.set(text, forKey: Keys.imageName.rawValue)
    }

    func loadImageName() -> String? {
        
        return defaults.object(forKey: Keys.imageName.rawValue) as? String
    }
    
    
    
    }
