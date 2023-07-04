import Fluent
import Vapor

final class Project: Model, Content {
    static let schema = "projects"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "display_name")
    var displayName: String
    
    @Field(key: "about_description")
    var aboutDescription: String
    
    @Field(key: "address_line1")
    var addressLine1: String
    
    @Field(key: "address_line2")
    var addressLine2: String
    
    @Field(key: "city")
    var city: String
    
    @Field(key: "province")
    var province: String
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "postal_code")
    var postalCode: String
    
    @Field(key: "phone_number")
    var phoneNumber: String
    
    @Field(key: "fax_number")
    var faxNumber: String
    
    @Field(key: "email_address")
    var emailAddress: String
    
    @Timestamp(key: "time_created", on: .create)
    var timeCreated: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String, displayName: String, aboutDescription: String, addressLine1: String, addressLine2: String, city: String, province: String, country: String, postalCode: String, phoneNumber: String, faxNumber: String, emailAddress: String, timeCreated: Date?) {
        self.id = id
        self.name = name
        self.displayName = displayName
        self.aboutDescription = aboutDescription
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
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
