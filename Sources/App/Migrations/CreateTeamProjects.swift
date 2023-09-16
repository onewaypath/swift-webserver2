//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 9/16/23.
//

import Fluent
import Foundation

class CreateTeamProjects: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("team_projects")
            .id()
            .field("team_id", .string, .required, .references("team", "id"))
            .field("heading", .string, .required)
            .field("description", .string, .required)
            .field("image", .string, .required)
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("team_projects")
            .delete()
    }
}
