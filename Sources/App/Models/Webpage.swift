//
//  webpage.swift
//  
//
//  Created by Alex Young on 5/30/23.
//

import Foundation
import Vapor
import Fluent

final class Webpage: Model {
    static let schema = "web_pages"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "leaf_template")
    var leafTemplate: String
    
    @Parent(key: "project_id")
    var projectID: Project
    
    @OptionalParent(key: "parent_id")
    var parent: Webpage?
    
    @Timestamp(key: "time_created", on: .create, format: .iso8601)
    var timeCreated: Date?
    
    init() {}
    
    init(id: Int? = nil, name: String, leafTemplate: String, projectID: Project.IDValue, parentID: Webpage.IDValue? = nil) {
        self.id = id
        self.name = name
        self.leafTemplate = leafTemplate
        self.$projectID.id = projectID
        self.$parent.id = parentID
    }
    
}


extension Webpage: Content {}

