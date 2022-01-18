//
//  ErrorView.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import SwiftUI

struct ErrorView: View {
    
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .padding(20)
            Text("Notes could not be updated right now, please try again later.")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .opacity(0.75)
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
