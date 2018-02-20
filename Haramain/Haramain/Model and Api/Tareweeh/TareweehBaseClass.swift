//
//  TareweehBaseClass.swift
//
//  Created by naman on 05/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TareweehBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let statusCode = "status_code"
    static let data = "data"
    static let message = "message"
  }

  // MARK: Properties
  public var statusCode: Int?
  public var data: [TareweehData]?
  public var message: String?

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
    statusCode = json[SerializationKeys.statusCode].int
    if let items = json[SerializationKeys.data].array { data = items.map { TareweehData(json: $0) } }
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = statusCode { dictionary[SerializationKeys.statusCode] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.statusCode = aDecoder.decodeObject(forKey: SerializationKeys.statusCode) as? Int
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [TareweehData]
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(statusCode, forKey: SerializationKeys.statusCode)
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
