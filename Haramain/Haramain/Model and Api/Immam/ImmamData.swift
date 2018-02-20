//
//  ImmamData.swift
//
//  Created by naman on 05/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ImmamData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let imaamDescription = "imaam_description"
    static let imaamId = "imaam_id"
    static let imaamName = "imaam_name"
    static let subCategoryId = "sub_category_id"
  }

  // MARK: Properties
  public var imaamDescription: String?
  public var imaamId: String?
  public var imaamName: String?
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
    imaamDescription = json[SerializationKeys.imaamDescription].string
    imaamId = json[SerializationKeys.imaamId].string
    imaamName = json[SerializationKeys.imaamName].string
    subCategoryId = json[SerializationKeys.subCategoryId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = imaamDescription { dictionary[SerializationKeys.imaamDescription] = value }
    if let value = imaamId { dictionary[SerializationKeys.imaamId] = value }
    if let value = imaamName { dictionary[SerializationKeys.imaamName] = value }
    if let value = subCategoryId { dictionary[SerializationKeys.subCategoryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.imaamDescription = aDecoder.decodeObject(forKey: SerializationKeys.imaamDescription) as? String
    self.imaamId = aDecoder.decodeObject(forKey: SerializationKeys.imaamId) as? String
    self.imaamName = aDecoder.decodeObject(forKey: SerializationKeys.imaamName) as? String
    self.subCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(imaamDescription, forKey: SerializationKeys.imaamDescription)
    aCoder.encode(imaamId, forKey: SerializationKeys.imaamId)
    aCoder.encode(imaamName, forKey: SerializationKeys.imaamName)
    aCoder.encode(subCategoryId, forKey: SerializationKeys.subCategoryId)
  }

}
