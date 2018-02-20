//
//  MakkahPlayerListUrls.swift
//
//  Created by naman on 19/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MakkahPlayerListUrls: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let alts = "alts"
    static let sheikh = "sheikh"
    static let type = "type"
    static let text = "text"
    static let url = "url"
  }

  // MARK: Properties
  public var alts: [String]?
  public var sheikh: String?
  public var type: String?
  public var text: String?
  public var url: String?

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
    if let items = json[SerializationKeys.alts].array { alts = items.map { $0.stringValue } }
    sheikh = json[SerializationKeys.sheikh].string
    type = json[SerializationKeys.type].string
    text = json[SerializationKeys.text].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = alts { dictionary[SerializationKeys.alts] = value }
    if let value = sheikh { dictionary[SerializationKeys.sheikh] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.alts = aDecoder.decodeObject(forKey: SerializationKeys.alts) as? [String]
    self.sheikh = aDecoder.decodeObject(forKey: SerializationKeys.sheikh) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(alts, forKey: SerializationKeys.alts)
    aCoder.encode(sheikh, forKey: SerializationKeys.sheikh)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
