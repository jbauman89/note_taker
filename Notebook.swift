import Foundation


class Notebook{
    
    var Notes: [String:Note] = [String:Note]()
    
    lazy var count = Notes.count
    
    init (firstNote: Note?){
        if firstNote == nil {
            return
        }
        else{
            self.Notes["Initial value"] = firstNote;
        }
    }
    
    func insert(note: Note)-> Void  {
        self.Notes[note.id] = note
    }
    
    func remove(note: Note) -> Note? {
   
        if let value = Notes.removeValue(forKey:note.id) {
                    print("The value \(value) was removed.")
                    return note
                } else {
                    print("No value found for that key.")
                    return nil
                }
    }
    
    func copy(note: Note) -> String {
    
        let newNote = Note(title: note.title, body: note.body, creationDate: Date())
        var counter = Note.idGEN
        counter += 1
        return "\(newNote.title)\(counter)"
        
    }
    
    func retrieve(noteWith name: String) -> Note? {

        for (_, value) in Notes.enumerated()
            {
            if value.0 == name
            {
                return value.1
            }
        }
        return nil
    }
    
    func printNotes() {
        for (_, value) in Notes.enumerated(){
            let note = value.1
            print(note.title, note.body)
            print("\n")
        }
    }
    
    
}
