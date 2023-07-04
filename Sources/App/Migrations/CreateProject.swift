//
//  CreateProject.swift
//  
//
//  Created by Alex Young on 5/30/23.
//

import Foundation
import Fluent

struct CreateProject: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("projects")
      .id()
      .field("name", .string, .required)
      .field("display_name", .string, .required)
      .field("about_description", .string, .required)
      .field("address_line1", .string, .required)
      .field("address_line2", .string, .required)
      .field("city", .string, .required)
      .field("province", .string, .required)
      .field("country", .string, .required)
      .field("postal_code", .string, .required)
      .field("phone_number", .string, .required)
      .field("fax_number", .string, .required)
      .field("email_address", .string, .required)
      .field("time_created", .datetime)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("projects").delete()
  }
}
