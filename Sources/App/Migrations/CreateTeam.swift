//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/13/23.
//

import Foundation
import Fluent

struct CreateTeam: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("teams")
            .id()
            .field("category", .string, .required)
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .field("position", .string, .required)
            .field("company", .string, .required)
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("teams")
            .delete()
    }
}
