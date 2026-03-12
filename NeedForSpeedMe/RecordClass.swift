import Foundation

final class RecordClass : Codable {
    var timeRace : Int
    var dateRace : Date
    var namePlayer : String
    
    init(timeRace: Int, dateRace: Date, namePlayer: String) {
        self.timeRace = timeRace
        self.dateRace = dateRace
        self.namePlayer = namePlayer
    }
}
