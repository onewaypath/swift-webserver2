//
//  ProjectsController.swift
//  
//
//  Created by Alex Young on 5/30/23.
//

import Foundation
import Vapor

struct ProjectsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let projectRoute = routes.grouped("api", "projects")
        projectRoute.post(use: createHandler)
        projectRoute.get(use: getAllHandler)
        projectRoute.get(":projectID", use: getHandler)
    }

//    func createHandler(_ req: Request) throws -> EventLoopFuture<Sites> {
//        let site = try req.content.decode(Sites.self)
//        return site.save(on: req.db).map { site }
//    }
//
  
    func createHandler(_ req: Request) throws -> EventLoopFuture<[Project]> {
        let projects = try req.content.decode([Project].self)
        let saveOperations = projects.map { $0.save(on: req.db) }
        
        return EventLoopFuture.whenAllSucceed(saveOperations, on: req.eventLoop).map { _ in
            return projects
        }
    }

    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Project]> {
        Project.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) -> EventLoopFuture<Project> {
        Project.find(req.parameters.get("siteID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}

