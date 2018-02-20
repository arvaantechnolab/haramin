//
//  ImageData.swift
//
//  Created by naman on 06/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ImageData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let imageThumbUrl = "image_thumb_url"
    static let imageUrl = "image_url"
    static let fileTitleEn = "file_title_en"
    static let galleryCategoryId = "gallery_category_id"
    static let galleryCategoryImageId = "gallery_category_image_id"
    static let fileType = "file_type"
  }

  // MARK: Properties
  public var imageThumbUrl: String?
  public var imageUrl: String?
  public var fileTitleEn: String?
  public var galleryCategoryId: String?
  public var galleryCategoryImageId: String?
  public var fileType: String?

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
    imageThumbUrl = json[SerializationKeys.imageThumbUrl].string
    imageUrl = json[SerializationKeys.imageUrl].string
    fileTitleEn = json[SerializationKeys.fileTitleEn].string
    galleryCategoryId = json[SerializationKeys.galleryCategoryId].string
    galleryCategoryImageId = json[SerializationKeys.galleryCategoryImageId].string
    fileType = json[SerializationKeys.fileType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = imageThumbUrl { dictionary[SerializationKeys.imageThumbUrl] = value }
    if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
    if let value = fileTitleEn { dictionary[SerializationKeys.fileTitleEn] = value }
    if let value = galleryCategoryId { dictionary[SerializationKeys.galleryCategoryId] = value }
    if let value = galleryCategoryImageId { dictionary[SerializationKeys.galleryCategoryImageId] = value }
    if let value = fileType { dictionary[SerializationKeys.fileType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.imageThumbUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageThumbUrl) as? String
    self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    self.fileTitleEn = aDecoder.decodeObject(forKey: SerializationKeys.fileTitleEn) as? String
    self.galleryCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryId) as? String
    self.galleryCategoryImageId = aDecoder.decodeObject(forKey: SerializationKeys.galleryCategoryImageId) as? String
    self.fileType = aDecoder.decodeObject(forKey: SerializationKeys.fileType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(imageThumbUrl, forKey: SerializationKeys.imageThumbUrl)
    aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    aCoder.encode(fileTitleEn, forKey: SerializationKeys.fileTitleEn)
    aCoder.encode(galleryCategoryId, forKey: SerializationKeys.galleryCategoryId)
    aCoder.encode(galleryCategoryImageId, forKey: SerializationKeys.galleryCategoryImageId)
    aCoder.encode(fileType, forKey: SerializationKeys.fileType)
  }

}
