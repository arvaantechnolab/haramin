//
//  MosqueSubCategory.swift
//
//  Created by naman on 27/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MosqueSubCategory: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let galleryCategoryName = "gallery_category_name"
    static let slug = "slug"
    static let galleryCategoryId = "gallery_category_id"
  }

  // MARK: Properties
  public var galleryCategoryName: String?
  public var slug: String?
  public var galleryCategoryId: String?

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
    galleryCategoryName = json[SerializationKeys.galleryCategoryName].string
    slug = json[SerializationKeys.slug].string
    galleryCategoryId = json[SerializationKeys.galleryCategoryId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = galleryCategoryName { dictionary[SerializationKeys.galleryCategoryName] = value }
    if let value = slug { dictionary[SerializationKeys.slug] = value }
    if let value = galleryCategoryId { dictionary[SerializationKeys.galleryCategoryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.galleryCategoryName = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryName) as? String
    self.slug = aDecoder.decodeObject(forKey: SerializationKeys.slug) as? String
    self.galleryCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(galleryCategoryName, forKey: SerializationKeys.galleryCategoryName)
    aCoder.encode(slug, forKey: SerializationKeys.slug)
    aCoder.encode(galleryCategoryId, forKey: SerializationKeys.galleryCategoryId)
  }

}
