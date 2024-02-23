//
//  FirestoreManager.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfigInternal

class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    

}

extension RemoteConfigManager {
    
    func fetchJSONData() async throws -> [String : Any]? {
        let rc = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        rc.configSettings = settings
        
        let json_data: [String : Any]?
        do {
            let config = try await rc.fetchAndActivate()
            switch config {
            case .successFetchedFromRemote:
                json_data = rc.configValue(forKey: RemoteConfigKeys.jsonData.rawValue).jsonValue as? [String : Any]
                return json_data
            case .successUsingPreFetchedData:
                json_data = rc.configValue(forKey: RemoteConfigKeys.jsonData.rawValue).jsonValue as? [String : Any]
                return json_data
            default:
                print("Error activating")
                return nil
            }
            
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
            throw error
        }
    }
    
}
