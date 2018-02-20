//
//  MosqueSubCategoryDetail.swift
//
//  Created by naman on 27/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MosqueSubCategoryDetail: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let slug = "slug"
    static let subCategoryName = "sub_category_name"
    static let subCategoryId = "sub_category_id"
  }

  // MARK: Properties
  public var slug: String?
  public var subCategoryName: String?
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
    slug = json[SerializationKeys.slug].string
    subCategoryName = json[SerializationKeys.subCategoryName].string
    subCategoryId = json[SerializationKeys.subCategoryId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = slug { dictionary[SerializationKeys.slug] = value }
    if let value = subCategoryName { dictionary[SerializationKeys.subCategoryName] = value }
    if let value = subCategoryId { dictionary[SerializationKeys.subCategoryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.slug = aDecoder.decodeObject(forKey: SerializationKeys.slug) as? String
    self.subCategoryName = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryName) as? String
    self.subCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(slug, forKey: SerializationKeys.slug)
    aCoder.encode(subCategoryName, forKey: SerializationKeys.subCategoryName)
    aCoder.encode(subCategoryId, forKey: SerializationKeys.subCategoryId)
  }

}
