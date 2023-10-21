//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 10/19/23.
//

import Fluent
import Foundation
import SQLKit

class CreateCityPlanningPrecedents: AsyncMigration {
    func prepare(on database: Database) async throws {
        let planning_precedents_status_enum_type = try await database.enum("planning_precedents_status_enum")
            .case("Approved")
            .case("Constructed")
            .create()

        try await database
            .schema("city_planning_precedents")
            .field("id", .int, .identifier(auto: true))
            .field("project_id", .int, .references("projects", "id"))
            .field("address", .string)
            .field("height", .float)
            .field("distance_to_subject", .float)
            .field("status", planning_precedents_status_enum_type)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("planning_precedents_status_enum")
            .delete()

        try await database
            .schema("city_planning_precedents")
            .delete()
    }
}
