//
//  Note.swift
//  NotesWatchOS WatchKit Extension
//
//  Created by Sebastian Morado on 1/18/22.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
