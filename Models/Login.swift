//
//  Login.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 28/04/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import Foundation

struct Login: Codable {
    let state, statusMsg: String
    let data: PurpleData

    enum CodingKeys: String, CodingKey {
        case state
        case statusMsg = "status_msg"
        case data
    }
}

struct PurpleData: Codable {
    let idUser, firstName, lastName, mail: String

    enum CodingKeys: String, CodingKey {
        case idUser = "id_user"
        case firstName = "first_name"
        case lastName = "last_name"
        case mail
    }
}

// MARK: Convenience initializers

extension Login {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Login.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension PurpleData {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(PurpleData.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
