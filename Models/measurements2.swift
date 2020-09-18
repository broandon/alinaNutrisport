// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updatedSepUserMeasurements = try? newJSONDecoder().decode(updatedSepUserMeasurements.self, from: jsonData)

import Foundation

// MARK: - updatedSepUserMeasurements
class updatedSepUserMeasurements: Codable {
    let state: String?
    let statusMsg: String?
    let data: updatedSepData?

    enum CodingKeys: String, CodingKey {
        case state
        case statusMsg
        case data
    }

    init(state: String?, statusMsg: String?, data: updatedSepData?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}

// MARK: - updatedSepData
class updatedSepData: Codable {
    let info: updatedSepInfo?

    enum CodingKeys: String, CodingKey {
        case info
    }

    init(info: updatedSepInfo?) {
        self.info = info
    }
}

// MARK: - updatedSepInfo
class updatedSepInfo: Codable {
    let id: String?
    let altura: String?
    let actividadFisica: String?
    let peso: String?
    let pGrasa: String?
    let pMusculo: String?
    let pAgua: String?
    let masaOsea: String?
    let grasaVisceral: String?
    let calorias: String?
    let evFisica: String?
    let edadMetabolica: String?
    let cinturaPerimetro: String?
    let caderaPerimetro: String?
    let brazoRelajadoPerimetro: String?
    let muniecaPerimetro: String?
    let pantorrillaPerimetro: String?
    let tobilloPerimetro: String?
    let antebrazoPerimetro: String?
    let pechoPerimetro: String?
    let fecha: String?
    let mejorPeso: String?
    let metabolismoBasal: String?
    let pesoEsperado: String?
    let tricepsGrasa: String?
    let bicepsGrasa: String?
    let abdominalGrasa: String?
    let pantorrillaGrasa: String?
    let subescopularGrasa: String?
    let suprailiacoGrasa: String?
    let musloGrasa: String?
    let abdomenPerimetro: String?
    let musloPerimetro: String?
    let comment: String?
    let imgTrack: JSONNull?
    let sexo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case altura
        case actividadFisica
        case peso
        case pGrasa
        case pMusculo
        case pAgua
        case masaOsea
        case grasaVisceral
        case calorias
        case evFisica
        case edadMetabolica
        case cinturaPerimetro
        case caderaPerimetro
        case brazoRelajadoPerimetro
        case muniecaPerimetro
        case pantorrillaPerimetro
        case tobilloPerimetro
        case antebrazoPerimetro
        case pechoPerimetro
        case fecha
        case mejorPeso
        case metabolismoBasal
        case pesoEsperado
        case tricepsGrasa
        case bicepsGrasa
        case abdominalGrasa
        case pantorrillaGrasa
        case subescopularGrasa
        case suprailiacoGrasa
        case musloGrasa
        case abdomenPerimetro
        case musloPerimetro
        case comment
        case imgTrack
        case sexo
    }

    init(id: String?, altura: String?, actividadFisica: String?, peso: String?, pGrasa: String?, pMusculo: String?, pAgua: String?, masaOsea: String?, grasaVisceral: String?, calorias: String?, evFisica: String?, edadMetabolica: String?, cinturaPerimetro: String?, caderaPerimetro: String?, brazoRelajadoPerimetro: String?, muniecaPerimetro: String?, pantorrillaPerimetro: String?, tobilloPerimetro: String?, antebrazoPerimetro: String?, pechoPerimetro: String?, fecha: String?, mejorPeso: String?, metabolismoBasal: String?, pesoEsperado: String?, tricepsGrasa: String?, bicepsGrasa: String?, abdominalGrasa: String?, pantorrillaGrasa: String?, subescopularGrasa: String?, suprailiacoGrasa: String?, musloGrasa: String?, abdomenPerimetro: String?, musloPerimetro: String?, comment: String?, imgTrack: JSONNull?, sexo: String?) {
        self.id = id
        self.altura = altura
        self.actividadFisica = actividadFisica
        self.peso = peso
        self.pGrasa = pGrasa
        self.pMusculo = pMusculo
        self.pAgua = pAgua
        self.masaOsea = masaOsea
        self.grasaVisceral = grasaVisceral
        self.calorias = calorias
        self.evFisica = evFisica
        self.edadMetabolica = edadMetabolica
        self.cinturaPerimetro = cinturaPerimetro
        self.caderaPerimetro = caderaPerimetro
        self.brazoRelajadoPerimetro = brazoRelajadoPerimetro
        self.muniecaPerimetro = muniecaPerimetro
        self.pantorrillaPerimetro = pantorrillaPerimetro
        self.tobilloPerimetro = tobilloPerimetro
        self.antebrazoPerimetro = antebrazoPerimetro
        self.pechoPerimetro = pechoPerimetro
        self.fecha = fecha
        self.mejorPeso = mejorPeso
        self.metabolismoBasal = metabolismoBasal
        self.pesoEsperado = pesoEsperado
        self.tricepsGrasa = tricepsGrasa
        self.bicepsGrasa = bicepsGrasa
        self.abdominalGrasa = abdominalGrasa
        self.pantorrillaGrasa = pantorrillaGrasa
        self.subescopularGrasa = subescopularGrasa
        self.suprailiacoGrasa = suprailiacoGrasa
        self.musloGrasa = musloGrasa
        self.abdomenPerimetro = abdomenPerimetro
        self.musloPerimetro = musloPerimetro
        self.comment = comment
        self.imgTrack = imgTrack
        self.sexo = sexo
    }
}
