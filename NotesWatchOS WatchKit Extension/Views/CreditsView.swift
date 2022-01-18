//
//  CreditsView.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import SwiftUI

struct CreditsView: View {
    
    
    var body: some View {
        
        VStack(spacing: 3) {
            Text("Credits".uppercased())
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
            
            Spacer()
            Image("developer-no1")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            Text("Sebastian Morado")
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
