//
//  MosqueData.swift
//
//  Created by naman on 27/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MosqueData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let masjidAlNabawi = "masjid-al-nabawi"
    static let galleryKey = "gallery-key"
    static let masjidAlHaram = "masjid-al-haram"
  }

  // MARK: Properties
  public var masjidAlNabawi: MosqueMasjidAlNabawi?
  public var galleryKey: [MosqueGalleryKey]?
  public var masjidAlHaram: MosqueMasjidAlHaram?

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
    masjidAlNabawi = MosqueMasjidAlNabawi(json: json[SerializationKeys.masjidAlNabawi])
    if let items = json[SerializationKeys.galleryKey].array { galleryKey = items.map { MosqueGalleryKey(json: $0) } }
    masjidAlHaram = MosqueMasjidAlHaram(json: json[SerializationKeys.masjidAlHaram])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = masjidAlNabawi { dictionary[SerializationKeys.masjidAlNabawi] = value.dictionaryRepresentation() }
    if let value = galleryKey { dictionary[SerializationKeys.galleryKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = masjidAlHaram { dictionary[SerializationKeys.masjidAlHaram] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.masjidAlNabawi = aDecoder.decodeObject(forKey: SerializationKeys.masjidAlNabawi) as? MosqueMasjidAlNabawi
    self.galleryKey = aDecoder.decodeObject(forKey: SerializationKeys.galleryKey) as? [MosqueGalleryKey]
    self.masjidAlHaram = aDecoder.decodeObject(forKey: SerializationKeys.masjidAlHaram) as? MosqueMasjidAlHaram
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(masjidAlNabawi, forKey: SerializationKeys.masjidAlNabawi)
    aCoder.encode(galleryKey, forKey: SerializationKeys.galleryKey)
    aCoder.encode(masjidAlHaram, forKey: SerializationKeys.masjidAlHaram)
  }

}
