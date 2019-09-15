//
//  PreferenceHelper.swift
//  ResumeBuild
//
//  Created by Janki on 13/05/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import Foundation

class PreferenceHelper : NSObject {
    private let KEY_PHONE_NUMBER_MAX_LENGTH = "phone_number_max_length";
    private let KEY_PHONE_NUMBER_MIN_LENGTH = "phone_number_min_length";
    let ph = UserDefaults.standard;
    static let preferenceHelper = PreferenceHelper()
    private override init(){
    }
    
    func getMaxPhoneNumberLength() -> Int
    {
        return (ph.value(forKey: KEY_PHONE_NUMBER_MAX_LENGTH) as? Int) ?? 12
    }
    func setMaxPhoneNumberLength(_ length:Int)
    {
        ph.set(length, forKey: KEY_PHONE_NUMBER_MAX_LENGTH);
        ph.synchronize();
    }
    func getMinPhoneNumberLength() -> Int
    {
        return (ph.value(forKey: KEY_PHONE_NUMBER_MIN_LENGTH) as? Int) ?? 10
    }
    func setMinPhoneNumberLength(_ length:Int)
    {
        ph.set(length, forKey: KEY_PHONE_NUMBER_MIN_LENGTH);
        ph.synchronize();
    }
}
