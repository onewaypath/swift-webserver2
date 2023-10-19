//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 10/19/23.
//

import Fluent
import Foundation
import SQLKit

class CreateCityPlanningProgress: AsyncMigration {
    func prepare(on database: Database) async throws {
        let city_planning_progress_status_enum_type = try await database.enum("city_planning_progress_status_enum")
            .case("Complete")
            .case("Pending")
            .create()

        try await database
            .schema("city_planning_progress")
            .field("id", .int, .identifier(auto: true))
            .field("project_id", .int, .references("projects", "id"))
            .field("progress_item", .string)
            .field("category", city_planning_progress_status_enum_type)
            .field("status", .string)
            .field("target", .date)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("city_planning_progress_status_enum")
            .delete()

        try await database
            .schema("city_planning_progress")
            .delete()
    }
}
