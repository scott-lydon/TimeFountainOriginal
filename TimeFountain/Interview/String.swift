//
//  String.swift
//  ScottLydon
//
//  Created by Scott Lydon on 10/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation

public typealias DictionaryAction = ([String: Any]) -> Void

public extension String {
    
    init(scape value: String, equals secondValue: String) {
        self = "\(value.scaped ?? "")=\(secondValue.scaped ?? "")&"
    }
    
    // MARK - computed properties
    
    var hasACharacter: Bool {
        return count > 0
    }
    
    var isNotValidEmail: Bool {
        return !isValidEmail
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    static var generateBoundaryString: String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    // MARK - self variations
    
    var nonSpaceCharacters: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    var lowercased: String {
        return lowercased()
    }
    
    var int: Int? {
        return Int(self)
    }
    
    var privacyDots: String {
        return String (self.map {_ in return Character("*")})
    }
    
    func times(_ int: Int) -> [String] {
        return Array(0...int - 1).map { _ in self}
    }
    
    var intBool: Bool {
        return self == "1"
    }
    
    var date: Date? {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(identifier: "GMT")
        return df.date(from: self)
    }
    
    var dateFromAPI: Date? {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(identifier: "GMT")
        return df.date(from: self)
    }
    
    var scaped: String? {
        return addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )
    }
    
    typealias AttributedString = NSMutableAttributedString
    
    // MARK  - attributed versions
    
    

    
    // MARK - initializers
    
    init(key: String, _ value: String) {
        self = "\(key)=\(value.scaped ?? "")&"
    }
    
    static var appVersion: String? {
        return Bundle.version
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    
    ///If the string is an absolute url  this will make the call and fetch the JSON.  If not, this will do nothing.
    func getJSON(_ jsonAction: DictionaryAction? = nil) {
        assert(url != nil)
        url?.sessionDataTask(provideJSON: jsonAction)?.resume()
    }
    
    ///If the string is an absolute url this will make the call and fetch the document as a string.
    func getString(_ stringAction: StringAction? = nil) {
        assert(url != nil)
        url?.sessionDataTask(provideString: stringAction)?.resume()
    }
    
    func save(root: FileManager.SearchPathDirectory, pathStr: String) {
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(
                for: root,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: true
            )
            let fileURL = path.appendingPathComponent(pathStr)
            try write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("error creating file")
        }
    }
}
