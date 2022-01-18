//
//  ContentView.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import SwiftUI


struct ContentView: View {
    //MARK: - Property
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    @State private var isErrorPresented : Bool = false
    private var isButtonDisabled : Bool {
        return text.isEmpty
    }
    
    //MARK: - Function
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func addNote(text: String) {
        let newNote = Note(id: UUID(), text: text)
        notes.append(newNote)
        self.text = ""
        saveData()
    }
    
    func loadData() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                self.notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                //Do nothing
            }
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            isErrorPresented.toggle()
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            saveData()
        }
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Note", text: $text)
                Button {
                    addNote(text: text)
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .disabled(isButtonDisabled)
                .fixedSize()
                .buttonStyle(.plain)
                .foregroundColor(isButtonDisabled ? .gray : .accentColor)

            }
            Spacer()
            if notes.count == 0 {
                Spacer()
                HStack {
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .frame(width: 30)
                        .padding(.trailing)
                    Text("No Notes Yet")
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
                Spacer()
            } else {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    
                    
                    
                }
            }
        }
        .onAppear(perform: {
            loadData()
        })
        .sheet(isPresented: $isErrorPresented, content: {
            ErrorView()
        })
        .navigationTitle("Notes")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
