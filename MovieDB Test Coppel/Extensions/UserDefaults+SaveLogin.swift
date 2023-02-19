//
//  UserDefaults+SaveLogin.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 18/02/23.
//

import Foundation

extension UserDefaults {
    static func setLoginStatus(_ status: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: "login")
    }
    
    static func getLoginStatus() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "login")
    }
}
