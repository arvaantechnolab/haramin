//
//  SingerListData.swift
//
//  Created by naman on 12/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SingerListData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let muadhinName = "muadhin_name"
    static let mId = "m_id"
    static let subCategoryId = "sub_category_id"
  }

  // MARK: Properties
  public var muadhinName: String?
  public var mId: String?
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
    muadhinName = json[SerializationKeys.muadhinName].string
    mId = json[SerializationKeys.mId].string
    subCategoryId = json[SerializationKeys.subCategoryId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = muadhinName { dictionary[SerializationKeys.muadhinName] = value }
    if let value = mId { dictionary[SerializationKeys.mId] = value }
    if let value = subCategoryId { dictionary[SerializationKeys.subCategoryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.muadhinName = aDecoder.decodeObject(forKey: SerializationKeys.muadhinName) as? String
    self.mId = aDecoder.decodeObject(forKey: SerializationKeys.mId) as? String
    self.subCategoryId = aDecoder.decodeObject(forKey: SerializationKeys.subCategoryId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(muadhinName, forKey: SerializationKeys.muadhinName)
    aCoder.encode(mId, forKey: SerializationKeys.mId)
    aCoder.encode(subCategoryId, forKey: SerializationKeys.subCategoryId)
  }

}
