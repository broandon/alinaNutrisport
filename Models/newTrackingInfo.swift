//
//  newTrackingInfo.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 13/10/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sepNewTrackingInfo = try? newJSONDecoder().decode(sepNewTrackingInfo.self, from: jsonData)

// MARK: - sepNewTrackingInfo
class sepNewTrackingInfo: Codable {
    let state, statusMsg: String?
    let data: sepData?

    enum CodingKeys: String, CodingKey {
        case state
        case statusMsg = "status_msg"
        case data
    }

    init(state: String?, statusMsg: String?, data: sepData?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}

// MARK: - sepData
class sepData: Codable {
    let info: sepInfo?

    init(info: sepInfo?) {
        self.info = info
    }
}

// MARK: - sepInfo
class sepInfo: Codable {
    let id, altura, actividadFisica, peso: String?
    let pGrasa, pMusculo, pAgua, masaOsea: String?
    let grasaVisceral, calorias, evFisica, edadMetabolica: String?
    let cinturaPerimetro, caderaPerimetro, brazoRelajadoPerimetro, muniecaPerimetro: String?
    let pantorrillaPerimetro, tobilloPerimetro, antebrazoPerimetro, pechoPerimetro: String?
    let fecha, complexion, comment: String?
    let imgTrack: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case altura
        case actividadFisica = "actividad_fisica"
        case peso
        case pGrasa = "p_grasa"
        case pMusculo = "p_musculo"
        case pAgua = "p_agua"
        case masaOsea = "masa_osea"
        case grasaVisceral = "grasa_visceral"
        case calorias
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
        case fecha, complexion, comment
        case imgTrack = "img_track"
    }

    init(id: String?, altura: String?, actividadFisica: String?, peso: String?, pGrasa: String?, pMusculo: String?, pAgua: String?, masaOsea: String?, grasaVisceral: String?, calorias: String?, evFisica: String?, edadMetabolica: String?, cinturaPerimetro: String?, caderaPerimetro: String?, brazoRelajadoPerimetro: String?, muniecaPerimetro: String?, pantorrillaPerimetro: String?, tobilloPerimetro: String?, antebrazoPerimetro: String?, pechoPerimetro: String?, fecha: String?, complexion: String?, comment: String?, imgTrack: String?) {
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
        self.complexion = complexion
        self.comment = comment
        self.imgTrack = imgTrack
    }
}
