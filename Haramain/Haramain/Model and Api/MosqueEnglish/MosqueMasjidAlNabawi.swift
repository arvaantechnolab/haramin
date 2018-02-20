//
//  MosqueMasjidAlNabawi.swift
//
//  Created by naman on 27/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MosqueMasjidAlNabawi: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let catImage = "cat_image"
    static let subCategoryDetail = "sub_category_detail"
    static let categoryId = "category_id"
    static let categoryName = "category_name"
    static let audioUrl = "audio_url"
    static let videoUrl = "video_url"
  }

  // MARK: Properties
  public var catImage: [String]?
  public var subCategoryDetail: [MosqueSubCategoryDetail]?
  public var categoryId: String?
  public var categoryName: String?
  public var audioUrl: String?
  public var videoUrl: String?

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
    if let items = json[SerializationKeys.catImage].array { catImage = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.subCategoryDetail].array { subCategoryDetail = items.map { MosqueSubCategoryDetail(json: $0) } }
    categoryId = json[SerializationKeys.categoryId].string
    categoryName = json[SerializationKeys.categoryName].string
    audioUrl = json[SerializationKeys.audioUrl].string
    videoUrl = json[SerializationKeys.videoUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = catImage { dictionary[SerializationKeys.catImage] = value }
    if let value = subCategoryDetail { dictionary[SerializationKeys.subCategoryDetail] = value.map { $0.dictionaryRepresentation() } }
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    if let value = categoryName { dictionary[SerializationKeys.categoryName] = value }
    if let value = audioUrl { dictionary[SerializationKeys.audioUrl] = value }
    if let value = videoUrl { dictionary[SerializationKeys.videoUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.catImage = aDecoder.decodeObject(forKey: SerializationKeys.catImage) as? [String]
    self.subCategoryDetail = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryDetail) as? [MosqueSubCategoryDetail]
    self.categoryId = aDecoder.decodeObject(forKey: SerializationKeys.categoryId) as? String
    self.categoryName = aDecoder.decodeObject(forKey: SerializationKeys.categoryName) as? String
    self.audioUrl = aDecoder.decodeObject(forKey: SerializationKeys.audioUrl) as? String
    self.videoUrl = aDecoder.decodeObject(forKey: SerializationKeys.videoUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(catImage, forKey: SerializationKeys.catImage)
    aCoder.encode(subCategoryDetail, forKey: SerializationKeys.subCategoryDetail)
    aCoder.encode(categoryId, forKey: SerializationKeys.categoryId)
    aCoder.encode(categoryName, forKey: SerializationKeys.categoryName)
    aCoder.encode(audioUrl, forKey: SerializationKeys.audioUrl)
    aCoder.encode(videoUrl, forKey: SerializationKeys.videoUrl)
  }

}
