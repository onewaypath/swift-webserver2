//
//  File.swift
//  
//
//  Created by Carlos Aguilar on 8/24/23.
//

import Leaf

enum SortedElementListError: Error {
    case missingElementArray
}

struct SortedElementList: UnsafeUnescapedLeafTag {
    func render(_ ctx: LeafContext) throws -> LeafData {
        guard let bulletPoints = ctx.parameters[0].array else {
            throw SortedElementListError.missingElementArray
        }

        let results = bulletPoints
            .compactMap { $0.dictionary }
            .sorted { ($0["order"]?.int ?? 0) < ($1["order"]?.int ?? 0) }
            .map {
                "<li>\($0["text"]?.string ?? "")</li>"
            }

        return LeafData.string(results.joined())
    }
}
