//
//  SettingsView.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var slideValue: Float = 1.0
    
    //MARK: - Function
    func update() {
        lineCount = Int(slideValue)
    }
    
    func load() {
        DispatchQueue.main.async {
            slideValue = Float(lineCount)
        }
    }
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            //Header
            Text("Settings".uppercased())
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            Slider(value: Binding(get: {
                self.slideValue
            }, set: { newValue in
                self.slideValue = newValue
                self.update()
            }), in: 1...4, step: 1)
                .tint(.accentColor)
        }
        .onAppear(perform: load)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
