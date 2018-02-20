//
//  PreviousKhutbahData.swift
//
//  Created by naman on 08/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PreviousKhutbahData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let yearName = "year_name"
    static let yearId = "year_id"
    static let subCategoryId = "sub_category_id"
  }

  // MARK: Properties
  public var yearName: String?
  public var yearId: String?
  public var subCategoryId: String?

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
    yearName = json[SerializationKeys.yearName].string
    yearId = json[SerializationKeys.yearId].string
    subCategoryId = json[SerializationKeys.subCategoryId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = yearName { dictionary[SerializationKeys.yearName] = value }
    if let value = yearId { dictionary[SerializationKeys.yearId] = value }
    if let value = subCategoryId { dictionary[SerializationKeys.subCategoryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.yearName = aDecoder.decodeObject(forKey: SerializationKeys.yearName) as? String
    self.yearId = aDecoder.decodeObject(forKey: SerializationKeys.yearId) as? String
    self.subCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(yearName, forKey: SerializationKeys.yearName)
    aCoder.encode(yearId, forKey: SerializationKeys.yearId)
    aCoder.encode(subCategoryId, forKey: SerializationKeys.subCategoryId)
  }

}
