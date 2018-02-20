//
//  LanguageListData.swift
//
//  Created by naman on 11/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LanguageListData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let subCategoryId = "sub_category_id"
    static let languageId = "language_id"
    static let languageName = "language_name"
  }

  // MARK: Properties
  public var subCategoryId: String?
  public var languageId: String?
  public var languageName: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    subCategoryId = json[SerializationKeys.subCategoryId].string
    languageId = json[SerializationKeys.languageId].string
    languageName = json[SerializationKeys.languageName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = subCategoryId { dictionary[SerializationKeys.subCategoryId] = value }
    if let value = languageId { dictionary[SerializationKeys.languageId] = value }
    if let value = languageName { dictionary[SerializationKeys.languageName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.subCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryId) as? String
    self.languageId = aDecoder.decodeObject(forKey: SerializationKeys.languageId) as? String
    self.languageName = aDecoder.decodeObject(forKey: SerializationKeys.languageName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(subCategoryId, forKey: SerializationKeys.subCategoryId)
    aCoder.encode(languageId, forKey: SerializationKeys.languageId)
    aCoder.encode(languageName, forKey: SerializationKeys.languageName)
  }

}
