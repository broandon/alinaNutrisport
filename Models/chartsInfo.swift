// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let graphGraphicsDaa = try? newJSONDecoder().decode(graphGraphicsDaa.self, from: jsonData)

import Foundation

// MARK: - graphGraphicsDaa
class graphGraphicsDaa: Codable {
    let state: String?
    let statusMsg: String?
    let data: graphData?

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case statusMsg = "status_msg"
        case data = "data"
    }

    init(state: String?, statusMsg: String?, data: graphData?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}

// MARK: - graphData
class graphData: Codable {
    let graficas: [graphGrafica]?

    enum CodingKeys: String, CodingKey {
        case graficas = "Graficas"
    }

    init(graficas: [graphGrafica]?) {
        self.graficas = graficas
    }
}

// MARK: - graphGrafica
class graphGrafica: Codable {
    let id: String?
    let peso: String?
    let cinturaPerimetro: String?
    let pGrasa: String?
    let pMusculo: String?
    let fecha: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case peso = "peso"
        case cinturaPerimetro = "cintura_perimetro"
        case pGrasa = "p_grasa"
        case pMusculo = "p_musculo"
        case fecha = "fecha"
    }

    init(id: String?, peso: String?, cinturaPerimetro: String?, pGrasa: String?, pMusculo: String?, fecha: String?) {
        self.id = id
        self.peso = peso
        self.cinturaPerimetro = cinturaPerimetro
        self.pGrasa = pGrasa
        self.pMusculo = pMusculo
        self.fecha = fecha
    }
}
