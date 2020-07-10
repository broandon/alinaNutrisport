// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let firstProfileInfo = try? newJSONDecoder().decode(firstProfileInfo.self, from: jsonData)

import Foundation

// MARK: - firstProfileInfo
class firstProfileInfo: Codable {
    let state: String?
    let statusMsg: String?
    let data: firstData?

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case statusMsg = "status_msg"
        case data = "data"
    }

    init(state: String?, statusMsg: String?, data: firstData?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}

// MARK: - firstData
class firstData: Codable {
    let info: firstInfo?

    enum CodingKeys: String, CodingKey {
        case info = "info"
    }

    init(info: firstInfo?) {
        self.info = info
    }
}

// MARK: - firstInfo
class firstInfo: Codable {
    let nombre: String?
    let apellidos: String?
    let telefono: String?
    let imagen: String?

    enum CodingKeys: String, CodingKey {
        case nombre = "nombre"
        case apellidos = "apellidos"
        case telefono = "telefono"
        case imagen = "imagen"
    }

    init(nombre: String?, apellidos: String?, telefono: String?, imagen: String?) {
        self.nombre = nombre
        self.apellidos = apellidos
        self.telefono = telefono
        self.imagen = imagen
    }
}
