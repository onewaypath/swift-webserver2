import Fluent
import Vapor

final class Project: Model, Content {
    static let schema = "projects"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Field(key: "project_name")
    var name: String

    @Field(key: "nick_name")
    var nickName: String

    @Field(key: "legal_name")
    var displayName: String
    
    @Field(key: "about_text")
    var aboutDescription: String
    
    @Field(key: "address")
    var address: String
    
    @Field(key: "city")
    var city: String
    
    @Field(key: "province")
    var province: String
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "postal_code")
    var postalCode: String
    
    @Field(key: "telephone")
    var phoneNumber: String
    
    @Field(key: "fax")
    var faxNumber: String
    
    @Field(key: "email_address")
    var emailAddress: String
    
    @Timestamp(key: "record_creation_date", on: .create)
    var timeCreated: Date?
    
    init() {}
    
    init(id: Int? = nil, name: String, nickName: String, displayName: String, aboutDescription: String, address: String, city: String, province: String, country: String, postalCode: String, phoneNumber: String, faxNumber: String, emailAddress: String, timeCreated: Date?) {
        self.id = id
        self.name = name
        self.nickName = nickName
        self.displayName = displayName
        self.aboutDescription = aboutDescription
        self.address = address
        self.city = city
        self.province = province
        self.country = country
        self.postalCode = postalCode
        self.phoneNumber = phoneNumber
        self.faxNumber = faxNumber
        self.emailAddress = emailAddress
        self.timeCreated = timeCreated
    }

}

extension Project: Hashable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
