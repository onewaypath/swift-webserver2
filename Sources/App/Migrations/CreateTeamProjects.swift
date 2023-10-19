//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 9/16/23.
//

import Fluent
import Foundation
import SQLKit

class CreateTeamProjects: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("team_projects")
            .field("id", .int, .identifier(auto: true))
            .field("team_id", .int, .required, .references("teams", "id"))
            .field("heading", .string, .required)
            .field("description", .string, .required)
            .field("image", .string, .required)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("team_projects")
            .delete()
    }
}
