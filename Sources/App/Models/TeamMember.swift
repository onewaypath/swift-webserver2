//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/13/23.
//

import Fluent
import Vapor

final class TeamMember: Model, Content {
    static let schema: String = "teams"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Field(key: "category")
    var category: String

    @Field(key: "first_name")
    var firstName: String

    @Field(key: "last_name")
    var lastName: String

    @Field(key: "position")
    var position: String

    @Field(key: "company")
    var company: String

    @Field(key: "linkedin")
    var linkedIn: URL?

    @Field(key: "bio_link")
    var bioLink: URL?

    @Children(for: \.$teamMember)
    var bulletPoints: [BiographyBullet]

    init() {}

    init(id: Int? = nil, category: String, firstName: String, lastName: String, position: String, company: String) {
        self.id = id
        self.category = category
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.company = company
    }
}
