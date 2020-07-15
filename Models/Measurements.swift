// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileMeasurementsMeasurementsData = try? newJSONDecoder().decode(profileMeasurementsMeasurementsData.self, from: jsonData)

import Foundation

// MARK: - profileMeasurementsMeasurementsData
class profileMeasurementsMeasurementsData: Codable {
    let state: String?
    let statusMsg: String?
    let data: profileMeasurementsData?

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case statusMsg = "status_msg"
        case data = "data"
    }

    init(state: String?, statusMsg: String?, data: profileMeasurementsData?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}

// MARK: - profileMeasurementsData
class profileMeasurementsData: Codable {
    let info: profileMeasurementsInfo?

    enum CodingKeys: String, CodingKey {
        case info = "info"
    }

    init(info: profileMeasurementsInfo?) {
        self.info = info
    }
}

// MARK: - profileMeasurementsInfo
class profileMeasurementsInfo: Codable {
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
    let imgTrack: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case altura = "altura"
        case actividadFisica = "actividad_fisica"
        case peso = "peso"
        case pGrasa = "p_grasa"
        case pMusculo = "p_musculo"
        case pAgua = "p_agua"
        case masaOsea = "masa_osea"
        case grasaVisceral = "grasa_visceral"
        case calorias = "calorias"
        case evFisica = "ev_fisica"
        case edadMetabolica = "edad_metabolica"
        case cinturaPerimetro = "cintura_perimetro"
        case caderaPerimetro = "cadera_perimetro"
        case brazoRelajadoPerimetro = "brazo_relajado_perimetro"
        case muniecaPerimetro = "munieca_perimetro"
        case pantorrillaPerimetro = "pantorrilla_perimetro"
        case tobilloPerimetro = "tobillo_perimetro"
        case antebrazoPerimetro = "antebrazo_perimetro"
        case pechoPerimetro = "pecho_perimetro"
        case fecha = "fecha"
        case mejorPeso = "mejor_peso"
        case metabolismoBasal = "metabolismo_basal"
        case pesoEsperado = "peso_esperado"
        case tricepsGrasa = "triceps_grasa"
        case bicepsGrasa = "biceps_grasa"
        case abdominalGrasa = "abdominal_grasa"
        case pantorrillaGrasa = "pantorrilla_grasa"
        case subescopularGrasa = "subescopular_grasa"
        case suprailiacoGrasa = "suprailiaco_grasa"
        case musloGrasa = "muslo_grasa"
        case abdomenPerimetro = "abdomen_perimetro"
        case musloPerimetro = "muslo_perimetro"
        case comment = "comment"
        case imgTrack = "img_track"
    }

    init(id: String?, altura: String?, actividadFisica: String?, peso: String?, pGrasa: String?, pMusculo: String?, pAgua: String?, masaOsea: String?, grasaVisceral: String?, calorias: String?, evFisica: String?, edadMetabolica: String?, cinturaPerimetro: String?, caderaPerimetro: String?, brazoRelajadoPerimetro: String?, muniecaPerimetro: String?, pantorrillaPerimetro: String?, tobilloPerimetro: String?, antebrazoPerimetro: String?, pechoPerimetro: String?, fecha: String?, mejorPeso: String?, metabolismoBasal: String?, pesoEsperado: String?, tricepsGrasa: String?, bicepsGrasa: String?, abdominalGrasa: String?, pantorrillaGrasa: String?, subescopularGrasa: String?, suprailiacoGrasa: String?, musloGrasa: String?, abdomenPerimetro: String?, musloPerimetro: String?, comment: String?, imgTrack: String?) {
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
    }
}
