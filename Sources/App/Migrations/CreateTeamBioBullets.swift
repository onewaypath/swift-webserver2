//
//  CreateTeamBioBullets.swift
//
//
//  Created by Carlos Aguilar on 10/19/23.
//

import Fluent
import Foundation
import SQLKit

class CreateTeamBioBullets: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("team_bio_bullets")
            .field("id", .int, .identifier(auto: true))
            .field("team_id", .int, .references("teams", "id"))
            .field("bullet_text", .string)
            .field("bullet_order", .int)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("team_bio_bullets")
            .delete()
    }
}
