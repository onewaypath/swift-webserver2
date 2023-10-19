//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/13/23.
//

import Fluent
import Foundation
import SQLKit

struct CreateTeam: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema("teams")
            .field("id", .int, .identifier(auto: true))
            .field("category", .string, .required)
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .field("position", .string, .required)
            .field("company", .string, .required)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema("teams")
            .delete()
    }
}
