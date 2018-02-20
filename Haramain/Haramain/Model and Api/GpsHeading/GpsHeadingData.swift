//
//  GpsHeadingData.swift
//
//  Created by naman on 12/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GpsHeadingData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let categoryId = "category_id"
    static let gpsHeadingId = "gps_heading_id"
    static let gpsHeading = "gps_heading"
    static let gpsHeadingEn = "gps_heading_en"
  }

  // MARK: Properties
  public var categoryId: String?
  public var gpsHeadingId: String?
  public var gpsHeading: String?
  public var gpsHeadingEn: String?

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
    categoryId = json[SerializationKeys.categoryId].string
    gpsHeadingId = json[SerializationKeys.gpsHeadingId].string
    gpsHeading = json[SerializationKeys.gpsHeading].string
    gpsHeadingEn = json[SerializationKeys.gpsHeadingEn].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    if let value = gpsHeadingId { dictionary[SerializationKeys.gpsHeadingId] = value }
    if let value = gpsHeading { dictionary[SerializationKeys.gpsHeading] = value }
    if let value = gpsHeadingEn { dictionary[SerializationKeys.gpsHeadingEn] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.categoryId = aDecoder.decodeObject(forKey: SerializationKeys.categoryId) as? String
    self.gpsHeadingId = aDecoder.decodeObject(forKey: SerializationKeys.gpsHeadingId) as? String
    self.gpsHeading = aDecoder.decodeObject(forKey: SerializationKeys.gpsHeading) as? String
    self.gpsHeadingEn = aDecoder.decodeObject(forKey: SerializationKeys.gpsHeadingEn) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(categoryId, forKey: SerializationKeys.categoryId)
    aCoder.encode(gpsHeadingId, forKey: SerializationKeys.gpsHeadingId)
    aCoder.encode(gpsHeading, forKey: SerializationKeys.gpsHeading)
    aCoder.encode(gpsHeadingEn, forKey: SerializationKeys.gpsHeadingEn)
  }

}
