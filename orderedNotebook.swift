import Foundation

class OrderedNotebook : Notebook{
    
    var ordered = [String]()
    
    override init(firstNote: Note?) {
        super.init(firstNote: firstNote)
        if let note = firstNote
        {
            ordered.append(note.id)
        }
    }
    
    
    override func copy(note: Note) -> String {
        let id = super.copy(note: note)
        ordered.append(id)
        return id
    }
    
    override func remove(note: Note) -> Note? {
        let noteDelete = super.remove(note: note)
        if noteDelete != nil
        {
            if let index = ordered.firstIndex(where: { id in
                id == note.id})
            {
                ordered.remove(at: index)
            }
        }
        return noteDelete
    }
    
    override func printNotes() {
        ordered.forEach { id in
            if let note =  super.Notes[id]
            {
                print(note.title, note.body)
            }
        }
    }
    
    func append(note: Note){
        super.insert(note: note)
        ordered.append(note.id)
    }
    
    func insert(note: Note, position: Int){
        super.insert(note: note)
        if ordered.endIndex < position {
            ordered.insert(note.id, at: ordered.endIndex)
        }
        else
        {
            ordered.insert(note.id, at: position)
        }
    }
    
    func move(note from: Int, to position: Int) -> (moved: Bool, position: Int?) {
        if from > ordered.endIndex || from < ordered.startIndex ||
            ordered.endIndex < position || ordered.startIndex > position
        {
            return (false,nil)
        }
        let note = ordered[from]
        
        ordered.remove(at: from)
        if ordered.endIndex < position
        {
            ordered.insert(note, at: ordered.endIndex)
            return (true, ordered.endIndex)
        }
        ordered.insert(note, at: position)
        return (true, position)
    }
    
    func move(note: Note, to position: Int) -> (moved: Bool, position: Int?){
        if let from = ordered.firstIndex(where: { id in
            note.id == id})
        {
            return self.move(note: from, to: position)
        }else
        {
            return (false,nil)
        }
    }
    
    func sort(using closure: ((key: String, value: Note),
                              (key: String, value: Note)) -> Bool) {
        ordered = super.Notes.sorted(by: closure).map
        {
            item in item.value.id
        }
    }
}
