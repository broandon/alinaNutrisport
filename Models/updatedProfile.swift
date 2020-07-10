// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let firstUpdatedProfile = try? newJSONDecoder().decode(firstUpdatedProfile.self, from: jsonData)

import Foundation

// MARK: - firstUpdatedProfile
class firstUpdatedProfile: Codable {
    let state: String?
    let statusMsg: String?
    let data: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case statusMsg = "status_msg"
        case data = "data"
    }

    init(state: String?, statusMsg: String?, data: [JSONAny]?) {
        self.state = state
        self.statusMsg = statusMsg
        self.data = data
    }
}
