import Foundation

struct Note{
    
    static var idGEN : Int = 0
    
    
    var title : String = ""
    var body : String = ""
    var id : String = ""
    
    
    
    init(title: String, body: String, creationDate: Date){
        self.title = title
        self.body = body
        self.id = "\(title)-\(Note.idGEN)"            // 4.e.iii
        Note.idGEN += 1
        self.creationDate = creationDate
    }
    
    mutating func updateName(with name: String) -> String
    {
        let holder = self.title
        self.title = name
        return holder
    }
    
    mutating func updateBody(with text: String) -> String
    {
        let holder = self.body
        self.body = text
        return holder
    }
    
    mutating func appendBody(with text: String) -> Void
    {
        self.body.append(text)
    }
    
    enum priorityLvl : Int{
        
        case low
        case med
        case high
        
        mutating func incrementLvl()-> Void {
            switch self{
            case .low :
                self = .med
                print("med")
            case .med :
                self = .high
                print("high")
            case .high :
                self = .high
                print("Already at high")
            }
        }
        
        mutating func decrementLvl() -> Void
        {
            switch self
            {
            case .high :
                self = .med
                print("med")
            case .med :
                self = .low
                print("low")
            case .low :
                self = .low
                print("Already at low")
            }
        }
    
    }
    
    var instance = priorityLvl.low
    
    static let calendar = Calendar(identifier: .gregorian)
    
    var creationDate: Date = Date()
    
    lazy var eventDate : Date = creationDate.adding(hour: 24)
    
    mutating func setEventDate(event: Date?) {
        if let event = event{
        let formatter = DateFormatter()
            formatter.calendar = Note.calendar
            eventDate = event
            print(formatter.string(from: eventDate))
        }
        eventDate = Date()
        print(eventDate)
    }
}

extension Date {
    func adding(hour: Int) -> Date {
        return Note.calendar.date(byAdding: .hour , value: hour, to: self)!
    }
}
