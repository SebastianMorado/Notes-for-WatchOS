//
//  DetailView.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Property
    let note : Note
    let count: Int
    let index: Int
    
    @State private var isCreditsPresented : Bool = false
    @State private var isSettingsPresented : Bool = false
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //Header
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            //Content
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            //Footer
            HStack(alignment: .center){
                Button {
                    isSettingsPresented.toggle()
                } label: {
                    Image(systemName: "gear")
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $isSettingsPresented) {
                    SettingsView()
                }
                
                Spacer()
                
                Text("\(index + 1) / \(count)")
                
                Spacer()
                
                Button {
                    isCreditsPresented.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $isCreditsPresented) {
                    CreditsView()
                }

            }
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var note : Note = Note(id: UUID(), text: "Hello World")
    static var previews: some View {
        DetailView(note: note, count: 5, index: 1)
    }
}
