//
//  CreateWebpage.swift
//  
//
//  Created by Alex Young on 5/30/23.
//

import Foundation
import Fluent

struct CreateWebpage: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("web_pages")
            .id()
            .field("name", .string, .required)
            .field("leaf_template", .string, .required)
            .field("project_id", .uuid, .required)
            .field("parent_id", .uuid, .references("web_pages", "id"))
            .field("time_created", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .create()
    }
  
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("web_pages").delete()
    }
}
