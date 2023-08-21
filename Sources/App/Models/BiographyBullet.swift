//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/15/23.
//

import Fluent
import Vapor

final class BiographyBullet: Model, Content {
    static let schema: String = "team_bio_bullets"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Parent(key: "team_id")
    var teamMember: TeamMember

    @Field(key: "bullet_text")
    var text: String

    @Field(key: "bullet_order")
    var order: Int

    init() {}

    init(id: Int? = nil, teamMember: TeamMember, text: String, order: Int) {
        self.id = id
        self.teamMember = teamMember
        self.text = text
        self.order = order
    }
}
