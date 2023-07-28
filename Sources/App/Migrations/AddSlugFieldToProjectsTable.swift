//
//  AddSlugFieldToProjectsTable.swift
//  
//
//  Created by Carlos Aguilar on 7/27/23.
//

import Foundation
import Fluent

struct AddSlugFieldToProjectsTable: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("projects")
            .field("slug", .string)
            .update()
    }

    func revert(on database: Database) async throws {
        try await database.schema("projects")
            .deleteField("slug")
            .update()
    }
}
