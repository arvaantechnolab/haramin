//
//  MosqueGalleryKey.swift
//
//  Created by naman on 27/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MosqueGalleryKey: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let galleryCategoryId = "gallery_category_id"
    static let subCategory = "sub_category"
    static let galleryCategoryName = "gallery_category_name"
    static let slug = "slug"
  }

  // MARK: Properties
  public var galleryCategoryId: String?
  public var subCategory: [MosqueSubCategory]?
  public var galleryCategoryName: String?
  public var slug: String?

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
    galleryCategoryId = json[SerializationKeys.galleryCategoryId].string
    if let items = json[SerializationKeys.subCategory].array { subCategory = items.map { MosqueSubCategory(json: $0) } }
    galleryCategoryName = json[SerializationKeys.galleryCategoryName].string
    slug = json[SerializationKeys.slug].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = galleryCategoryId { dictionary[SerializationKeys.galleryCategoryId] = value }
    if let value = subCategory { dictionary[SerializationKeys.subCategory] = value.map { $0.dictionaryRepresentation() } }
    if let value = galleryCategoryName { dictionary[SerializationKeys.galleryCategoryName] = value }
    if let value = slug { dictionary[SerializationKeys.slug] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.galleryCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryId) as? String
    self.subCategory = aDecoder.decodeObject(forKey: SerializationKeys.subCategory) as? [MosqueSubCategory]
    self.galleryCategoryName = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryName) as? String
    self.slug = aDecoder.decodeObject(forKey: SerializationKeys.slug) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(galleryCategoryId, forKey: SerializationKeys.galleryCategoryId)
    aCoder.encode(subCategory, forKey: SerializationKeys.subCategory)
    aCoder.encode(galleryCategoryName, forKey: SerializationKeys.galleryCategoryName)
    aCoder.encode(slug, forKey: SerializationKeys.slug)
  }

}
