//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 9/17/23.
//

import Fluent
import Vapor

final class MemberProject: Model, Content {
    static let schema: String = "team_projects"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Parent(key: "team_id")
    var teamMember: TeamMember

    @Field(key: "heading")
    var heading: String

    @Field(key: "description")
    var description: String

    @Field(key: "image")
    var image: String

    init() {}

    init(id: Int? = nil, teamMember: TeamMember, heading: String, description: String, image: String) {
        self.id = id
        self.teamMember = teamMember
        self.heading = heading
        self.description = description
    }
}
