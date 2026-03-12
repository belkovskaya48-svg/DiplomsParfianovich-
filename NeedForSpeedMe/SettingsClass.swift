import UIKit

final class SettingsClass : Codable {
    var userName : String
    var blockName : String
    var carName : String
    
    init(userName: String, blockName: String, carName: String){
        self.userName = userName
        self.blockName = blockName
        self.carName = carName
    }
    var blockImage: UIImage? {
            return UIImage(named: blockName)
        }
        
        var carImage: UIImage? {
            return UIImage(named: carName)
        }
}
