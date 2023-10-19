//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 10/19/23.
//

import Fluent
import Foundation
import SQLKit

class CreateCommunityServices: AsyncMigration {
    func prepare(on database: Database) async throws {
        let category_enum_type = try await database.enum("category_enum")
            .case("Transportation")
            .case("Grocery Store")
            .case("Park")
            .case("Child Care")
            .case("School")
            .case("Community Centre")
            .create()

        try await database
            .schema("community_services")
            .field("id", .int, .identifier(auto: true))
            .field("project_id", .int, .required, .references("projects", "id"))
            .field("name", .string)
            .field("address", .string)
            .field("city", .string)
            .field("province", .string)
            .field("country", .string)
            .field("postal_code", .string)
            .field("category", category_enum_type)
            .field("subcategory", .string)
            .field("description", .string)
            .field("distance_km", .float)
            .field("travel_time_foot", .float)
            .field("travel_time_car", .float)
            .field("travel_time_transit", .float)
            .field("record_creation_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("record_amend_date", .custom(SQLRaw("TIMESTAMP WITHOUT TIME ZONE")), .sql(.default(SQLRaw("CURRENT_TIMESTAMP"))))
            .field("created_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .field("last_amended_by", .string, .sql(.default(SQLRaw("CURRENT_USER"))))
            .ignoreExisting()
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("category_enum")
            .delete()

        try await database
            .schema("community_services")
            .delete()
    }
}
