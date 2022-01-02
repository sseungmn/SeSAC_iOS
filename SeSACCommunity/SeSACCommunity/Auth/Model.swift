//
//  Model.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import Foundation

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let jwt: String
    let user: User
}

// MARK: User
struct User: Codable {
    let id: Int
    let username, email: String
    let posts: [Post]
    let comments: [Comment]
}

// MARK: - Board
typealias Board = [Post]

// MARK: Post
struct Post: Codable {
    let id: Int
    let text: String
    let user: AccessInfo
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
