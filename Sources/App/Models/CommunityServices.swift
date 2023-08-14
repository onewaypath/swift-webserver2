//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/13/23.
//

import Fluent
import Vapor

final class CommunityService: Model, Content {
    static let schema: String = "community_services"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Parent(key: "project_id")
    var project: Project

    @Field(key: "name")
    var name: String

    @Field(key: "address")
    var address: String?

    @Field(key: "city")
    var city: String?

    @Field(key: "province")
    var province: String?

    @Field(key: "country")
    var country: String?

    @Field(key: "postal_code")
    var postalCode: String?

    @Field(key: "category")
    var category: String

    @Field(key: "subcategory")
    var subcategory: String

    @Field(key: "description")
    var description: String?

    @Field(key: "distance_km")
    var distanceInKilometers: Double

    @Field(key: "travel_time_foot")
    var travelTimeFoot: Double

    @Field(key: "travel_time_car")
    var travelTimeCar: Double

    @Field(key: "travel_time_transit")
    var travelTimeTransit: Double

    @Field(key: "record_creation_date")
    var createdAt: Date?

    @Field(key: "record_amend_date")
    var updatedAt: Date?

    init() {}

    init(id: Int? = nil, project: Project, name: String, address: String?, city: String?, province: String?, country: String?, postalCode: String?, category: String, subcategory: String, description: String?, distanceInKilometers: Double, travelTimeFoot: Double, travelTimeCar: Double, travelTimeTransit: Double, createdAt: Date?, updatedAt: Date?) {
        self.id = id
        self.project = project
        self.name = name
        self.address = address
        self.city = city
        self.province = province
        self.country = country
        self.postalCode = postalCode
        self.category = category
        self.subcategory = subcategory
        self.description = description
        self.distanceInKilometers = distanceInKilometers
        self.travelTimeFoot = travelTimeFoot
        self.travelTimeCar = travelTimeCar
        self.travelTimeTransit = travelTimeTransit
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
