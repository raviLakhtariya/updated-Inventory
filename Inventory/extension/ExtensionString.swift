//
//  ExtensionString.swift
//  ResumeBuild
//
//  Created by Janki on 13/05/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import Foundation
import UIKit
//Type Casting Extension
extension String
{
    func toBool() -> Bool?
    {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    func toDouble() -> Double
    {
        return NumberFormat.instance.number(from: self)?.doubleValue ?? 0.0
    }
    func toInt() -> Int
    {
        return NumberFormat.instance.number(from: self)?.intValue ?? 0
    }
    func toDate (format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat=format
        return formatter.date(from: self) ?? Date()
    }
    func toCall()  {
        if let url = URL(string: "tel://\(self)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else
        {
            //Utility.showToast(message: "Unable to call")
        }
        
    }
}

//MARK: - Validation Extension
extension String
{
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func isEmpty() -> Bool {
        return  self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    func isValidEmail() ->Bool
    {
        let stremail = self.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines);
        if stremail.count > 0
        {
            let stricterFilterString:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            let emailRegex:String = stricterFilterString;
            let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex);
            return emailTest.evaluate(with: self);
        }
        else
        {
            return false;
        }
    }
    func isNumber() -> Bool
    {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty() && self.rangeOfCharacter(from:numberCharacters) == nil
    }
    func isValidMobileNumber() -> (Bool,String)
    {
        if self.isEmpty()
        {
            return (false,"VALIDATION_MSG_ENTER_PHONE_NUMBER"/*.localized*/)
        }
        else
        {
            if self.isNumber()
            {
                if (self.count >= preferenceHelper.getMinPhoneNumberLength() && self.count <= preferenceHelper.getMaxPhoneNumberLength())
                {
                    return (true,"");
                }
                else
                {
                    if preferenceHelper.getMaxPhoneNumberLength() == preferenceHelper.getMinPhoneNumberLength()
                    {
                        let myString = String(format: NSLocalizedString("VALIDATION_MSG_INVALID_PHONE_NUMBER", comment: ""),preferenceHelper.getMinPhoneNumberLength().toString())

                        return (false,myString);
                    }
                    else
                    {

                        let myString = String(format: NSLocalizedString("VALIDATION_MSG_INVALID_PHONE_NUMBER_BETWEEN", comment: ""),preferenceHelper.getMinPhoneNumberLength().toString(),preferenceHelper.getMaxPhoneNumberLength().toString())
                        return (false,myString);
                    }
                }
            }
            else
            {
                let myString = String(format: NSLocalizedString("VALIDATION_MSG_INVALID_PHONE_NUMBER_BETWEEN", comment: ""),preferenceHelper.getMinPhoneNumberLength().toString(),preferenceHelper.getMaxPhoneNumberLength().toString())
                return (false,myString);
            }
        }
        
    }
    struct NumberFormat    {
        static let instance = NumberFormatter()
    }
    
}


extension Double
{
    /// Rounds the double to decimal places value
    func roundTo(places:Int = 2) -> Double
    {
        let divisor = pow(10.00, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func toString(places:Int = 2) -> String
    {
        return String(format:"%."+places.description+"f", self)
    }
//    func toCurrencyString(currencyCode:String = ProviderSingleton.shared.provider.walletCurrencyCode) -> String
//    {
//        var locale = Locale.current
//        if CurrencyHelper.shared.myLocale.currencyCode == currencyCode
//        {
//            locale = CurrencyHelper.shared.myLocale
//        }
//        else
//        {
//            for iteratedLocale in Locale.availableIdentifiers
//            {
//                let newLocal = Locale.init(identifier: iteratedLocale)
//                if newLocal.currencyCode == currencyCode
//                {
//                    locale = newLocal
//                    break;
//                }
//            }
//        }
//        if locale.identifier.contains("_")
//        {
//            let strings = locale.identifier.components(separatedBy: "_")
//            if strings.count > 0
//            {
//                let countryCode = strings[strings.count - 1]
//                
//                locale = Locale.init(identifier: "\(arrForLanguages[preferenceHelper.getLanguage()].code)_\(countryCode)")
//            }
//        }
//        else
//        {
//            locale = Locale.init(identifier: "\(arrForLanguages[preferenceHelper.getLanguage()].code)_\(locale.identifier)")
//            
//        }
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = locale
//        CurrencyHelper.shared.myLocale = locale
//        return formatter.string(from: NSNumber.init(value: self) ) ?? self.toString(places: 2);
//    }
    func toInt() -> Int
    {
        if self > Double(Int.min) && self < Double(Int.max)
        {
            return Int(self)
        }
        else {
            return 0
        }
    }
    
}



extension Int
{
    func toString() -> String
    {
        return   String(self )
    }
}
