//
//  ConsentSDK+ObjC.swift
//  ConsentSDK
//
//  Created by Pavel Kroh on 18/02/2019.
//  Copyright © 2019 Smartlook. All rights reserved.
//

import Foundation

/**
 This array must be filled alternativelly by values of `NSString` (preferably a constant defined in `CSDKConsent` class) and the respective default value for `CSDKConsentState`: [NSString, @(CSDKConsentState), NSString, @(CSDKConsentState)...]
 */
public typealias CSDKConsentsSettings = Array<Any>

extension ConsentSDK {
    
    static func settings(from objcSettings: CSDKConsentsSettings) -> ConsentsSettings {
        var swiftConsents = ConsentsSettings()
        for i in stride(from: 0, to: objcSettings.count - 1, by: 2) {
            if let consent = objcSettings[i] as? Consent, let rawValue = objcSettings[i + 1] as? Int, let state = ConsentState(rawValue: rawValue) {
                swiftConsents.append((consent, state))
            }
        }
        return swiftConsents
    }

    @objc public static func show(with consentsSettings: CSDKConsentsSettings, callback: @escaping RequestIdCallback) {
        show(with: settings(from: consentsSettings), callback: callback)
    }
    
    @objc public static func check(with consentsSettings: CSDKConsentsSettings, callback: @escaping RequestIdCallback) {
        check(with: settings(from: consentsSettings), callback: callback)
    }
    
}
