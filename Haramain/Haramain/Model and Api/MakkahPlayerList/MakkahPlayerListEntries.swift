//
//  MakkahPlayerListEntries.swift
//
//  Created by naman on 19/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MakkahPlayerListEntries: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sheikh = "sheikh"
    static let hijriDate = "hijri_date"
    static let entryTypeText = "entry_type_text"
    static let entrySubtype = "entry_subtype"
    static let entryDate = "entry_date"
    static let id = "id"
    static let entryType = "entry_type"
    static let urls = "urls"
    static let isEdited = "is_edited"
    static let videos = "videos"
    static let title = "title"
    static let suraText = "sura_text"
    static let lastUpdated = "last_updated"
    static let postUrl = "post_url"
  }

  // MARK: Properties
  public var sheikh: Int?
  public var hijriDate: String?
  public var entryTypeText: String?
  public var entrySubtype: Int?
  public var entryDate: String?
  public var id: Int?
  public var entryType: Int?
  public var urls: [MakkahPlayerListUrls]?
  public var isEdited: Int?
  public var videos: [String]?
  public var title: String?
  public var suraText: String?
  public var lastUpdated: String?
  public var postUrl: String?

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
    sheikh = json[SerializationKeys.sheikh].int
    hijriDate = json[SerializationKeys.hijriDate].string
    entryTypeText = json[SerializationKeys.entryTypeText].string
    entrySubtype = json[SerializationKeys.entrySubtype].int
    entryDate = json[SerializationKeys.entryDate].string
    id = json[SerializationKeys.id].int
    entryType = json[SerializationKeys.entryType].int
    if let items = json[SerializationKeys.urls].array { urls = items.map { MakkahPlayerListUrls(json: $0) } }
    isEdited = json[SerializationKeys.isEdited].int
    if let items = json[SerializationKeys.videos].array { videos = items.map { $0.stringValue } }
    title = json[SerializationKeys.title].string
    suraText = json[SerializationKeys.suraText].string
    lastUpdated = json[SerializationKeys.lastUpdated].string
    postUrl = json[SerializationKeys.postUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sheikh { dictionary[SerializationKeys.sheikh] = value }
    if let value = hijriDate { dictionary[SerializationKeys.hijriDate] = value }
    if let value = entryTypeText { dictionary[SerializationKeys.entryTypeText] = value }
    if let value = entrySubtype { dictionary[SerializationKeys.entrySubtype] = value }
    if let value = entryDate { dictionary[SerializationKeys.entryDate] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = entryType { dictionary[SerializationKeys.entryType] = value }
    if let value = urls { dictionary[SerializationKeys.urls] = value.map { $0.dictionaryRepresentation() } }
    if let value = isEdited { dictionary[SerializationKeys.isEdited] = value }
    if let value = videos { dictionary[SerializationKeys.videos] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = suraText { dictionary[SerializationKeys.suraText] = value }
    if let value = lastUpdated { dictionary[SerializationKeys.lastUpdated] = value }
    if let value = postUrl { dictionary[SerializationKeys.postUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.sheikh = aDecoder.decodeObject(forKey: SerializationKeys.sheikh) as? Int
    self.hijriDate = aDecoder.decodeObject(forKey: SerializationKeys.hijriDate) as? String
    self.entryTypeText = aDecoder.decodeObject(forKey: SerializationKeys.entryTypeText) as? String
    self.entrySubtype = aDecoder.decodeObject(forKey: SerializationKeys.entrySubtype) as? Int
    self.entryDate = aDecoder.decodeObject(forKey: SerializationKeys.entryDate) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.entryType = aDecoder.decodeObject(forKey: SerializationKeys.entryType) as? Int
    self.urls = aDecoder.decodeObject(forKey: SerializationKeys.urls) as? [MakkahPlayerListUrls]
    self.isEdited = aDecoder.decodeObject(forKey: SerializationKeys.isEdited) as? Int
    self.videos = aDecoder.decodeObject(forKey: SerializationKeys.videos) as? [String]
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.suraText = aDecoder.decodeObject(forKey: SerializationKeys.suraText) as? String
    self.lastUpdated = aDecoder.decodeObject(forKey: SerializationKeys.lastUpdated) as? String
    self.postUrl = aDecoder.decodeObject(forKey: SerializationKeys.postUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(sheikh, forKey: SerializationKeys.sheikh)
    aCoder.encode(hijriDate, forKey: SerializationKeys.hijriDate)
    aCoder.encode(entryTypeText, forKey: SerializationKeys.entryTypeText)
    aCoder.encode(entrySubtype, forKey: SerializationKeys.entrySubtype)
    aCoder.encode(entryDate, forKey: SerializationKeys.entryDate)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(entryType, forKey: SerializationKeys.entryType)
    aCoder.encode(urls, forKey: SerializationKeys.urls)
    aCoder.encode(isEdited, forKey: SerializationKeys.isEdited)
    aCoder.encode(videos, forKey: SerializationKeys.videos)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(suraText, forKey: SerializationKeys.suraText)
    aCoder.encode(lastUpdated, forKey: SerializationKeys.lastUpdated)
    aCoder.encode(postUrl, forKey: SerializationKeys.postUrl)
  }

}
