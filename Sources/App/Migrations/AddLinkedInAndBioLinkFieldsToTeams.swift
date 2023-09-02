//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/13/23.
//

import Fluent
import Foundation

struct AddLinkedInAndBioLinkFieldsToTeams: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("teams")
            .field("linkedin", .string)
            .field("bio_link", .string)
            .update()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("teams")
            .deleteField("linkedin")
            .deleteField("bio_link")
            .update()
    }
}
