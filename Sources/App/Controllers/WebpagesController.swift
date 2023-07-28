import Foundation
import Vapor

struct WebpagesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let webpagesRoute = routes.grouped("api", "webpages")
        webpagesRoute.post(use: createHandler)
        webpagesRoute.get(use: getAllHandler)
        webpagesRoute.get(":webpageID", use: getHandler)
    }

    func createHandler(_ req: Request) throws -> EventLoopFuture<[Webpage]> {
        let data = try req.content.decode(CreateWebpageData.self)
        
        let webpages = data.webpages.map { webpageData -> Webpage in
            return Webpage(name: webpageData.name,
                           leafTemplate: webpageData.leafTemplate,
                           projectID: data.projectID)
        }
        
        let saveOperations = webpages.map { $0.save(on: req.db) }
        
        return EventLoopFuture.whenAllSucceed(saveOperations, on: req.eventLoop).map { _ in
            return webpages
        }
    }

    func getAllHandler(_ req: Request) -> EventLoopFuture<[Webpage]> {
        return Webpage.query(on: req.db).all()
    }

    func getHandler(_ req: Request) throws -> EventLoopFuture<Webpage> {
        guard let webpageID = req.parameters.get("webpageID", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        return Webpage.find(webpageID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}

struct CreateWebpageData: Content {
    let projectID: Int
    let webpages: [WebpageData]
}

struct WebpageData: Content {
    let name: String
    let leafTemplate: String
}
