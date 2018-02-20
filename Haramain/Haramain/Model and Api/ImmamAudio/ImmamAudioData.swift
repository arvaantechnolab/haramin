//
//  ImmamAudioData.swift
//
//  Created by naman on 05/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ImmamAudioData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let favoriteFlag = "favorite_flag"
    static let audioName = "audio_name"
    static let imaamName = "imaam_name"
    static let audioAuther = "audio_auther"
    static let audioArtist = "audio_artist"
    static let audioTitle = "audio_title"
    static let fileName = "file_name"
    static let subCategoryName = "sub_category_name"
    static let surahName = "surah_name"
    static let audioId = "audio_id"
    static let audioUrl = "audio_url"
  }

  // MARK: Properties
  public var favoriteFlag: Bool? = false
  public var audioName: String?
  public var imaamName: String?
  public var audioAuther: String?
  public var audioArtist: String?
  public var audioTitle: String?
  public var fileName: String?
  public var subCategoryName: String?
  public var surahName: String?
  public var audioId: String?
  public var audioUrl: String?

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
    favoriteFlag = json[SerializationKeys.favoriteFlag].boolValue
    audioName = json[SerializationKeys.audioName].string
    imaamName = json[SerializationKeys.imaamName].string
    audioAuther = json[SerializationKeys.audioAuther].string
    audioArtist = json[SerializationKeys.audioArtist].string
    audioTitle = json[SerializationKeys.audioTitle].string
    fileName = json[SerializationKeys.fileName].string
    subCategoryName = json[SerializationKeys.subCategoryName].string
    surahName = json[SerializationKeys.surahName].string
    audioId = json[SerializationKeys.audioId].string
    audioUrl = json[SerializationKeys.audioUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.favoriteFlag] = favoriteFlag
    if let value = audioName { dictionary[SerializationKeys.audioName] = value }
    if let value = imaamName { dictionary[SerializationKeys.imaamName] = value }
    if let value = audioAuther { dictionary[SerializationKeys.audioAuther] = value }
    if let value = audioArtist { dictionary[SerializationKeys.audioArtist] = value }
    if let value = audioTitle { dictionary[SerializationKeys.audioTitle] = value }
    if let value = fileName { dictionary[SerializationKeys.fileName] = value }
    if let value = subCategoryName { dictionary[SerializationKeys.subCategoryName] = value }
    if let value = surahName { dictionary[SerializationKeys.surahName] = value }
    if let value = audioId { dictionary[SerializationKeys.audioId] = value }
    if let value = audioUrl { dictionary[SerializationKeys.audioId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.favoriteFlag = aDecoder.decodeBool(forKey: SerializationKeys.favoriteFlag)
    self.audioName = aDecoder.decodeObject(forKey: SerializationKeys.audioName) as? String
    self.imaamName = aDecoder.decodeObject(forKey: SerializationKeys.imaamName) as? String
    self.audioAuther = aDecoder.decodeObject(forKey: SerializationKeys.audioAuther) as? String
    self.audioArtist = aDecoder.decodeObject(forKey: SerializationKeys.audioArtist) as? String
    self.audioTitle = aDecoder.decodeObject(forKey: SerializationKeys.audioTitle) as? String
    self.fileName = aDecoder.decodeObject(forKey: SerializationKeys.fileName) as? String
    self.subCategoryName = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryName) as? String
    self.surahName = aDecoder.decodeObject(forKey: SerializationKeys.surahName) as? String
    self.audioId = aDecoder.decodeObject(forKey: SerializationKeys.audioId) as? String
    self.audioUrl = aDecoder.decodeObject(forKey: SerializationKeys.audioUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(favoriteFlag, forKey: SerializationKeys.favoriteFlag)
    aCoder.encode(audioName, forKey: SerializationKeys.audioName)
    aCoder.encode(imaamName, forKey: SerializationKeys.imaamName)
    aCoder.encode(audioAuther, forKey: SerializationKeys.audioAuther)
    aCoder.encode(audioArtist, forKey: SerializationKeys.audioArtist)
    aCoder.encode(audioTitle, forKey: SerializationKeys.audioTitle)
    aCoder.encode(fileName, forKey: SerializationKeys.fileName)
    aCoder.encode(subCategoryName, forKey: SerializationKeys.subCategoryName)
    aCoder.encode(surahName, forKey: SerializationKeys.surahName)
    aCoder.encode(audioId, forKey: SerializationKeys.audioId)
    aCoder.encode(audioUrl, forKey: SerializationKeys.audioUrl)
  }

}
