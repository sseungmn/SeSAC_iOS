//
//  Board.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import Foundation

typealias Board = [Post]
// MARK: - BoardElement
struct Post: Codable {
    let id: Int
    let text: String
    let usersPermissionsUser: UsersPermissionsUser
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text
        case usersPermissionsUser = "users_permissions_user"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUser: Codable {
    let id: Int
    let username, email, provider: String
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

