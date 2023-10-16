//
//  CreateProject.swift
//  
//
//  Created by Alex Young on 5/30/23.
//

import Fluent
import Foundation
import SQLKit

struct CreateProject: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("projects")
      .field("id", .int, .identifier(auto: true))
      .field("project_name", .string)
      .field("about_text", .string)
      .field("url", .string, .required)
      .field("legal_name", .string)
      .field("nickname", .string)
      .field("address", .string)
      .field("city", .string)
      .field("province", .string)
      .field("country", .string)
      .field("postal_code", .string)
      .field("telephone", .string)
      .field("fax", .string)
      .field("email_address", .string)
      .field("record_creation_date", .datetime, .sql(.default(SQLFunction("CURRENT_TIMESTAMP"))))
      .field("record_amend_date", .datetime, .sql(.default(SQLFunction("CURRENT_TIMESTAMP"))))
      .field("created_by", .string, .sql(.default(SQLFunction("CURRENT_USER"))))
      .field("last_amended_by", .string, .sql(.default(SQLFunction("CURRENT_USER"))))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("projects").delete()
  }
}
