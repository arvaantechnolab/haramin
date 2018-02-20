//
//  GpsSubHeadingData.swift
//
//  Created by naman on 12/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GpsSubHeadingData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let gpsPlaceEn = "gps_place_en"
    static let gpsSubHeadingId = "gps_sub_heading_id"
    static let gpsPlace = "gps_place"
    static let gpsHeadingId = "gps_heading_id"
    static let longitude = "longitude"
  }

  // MARK: Properties
  public var latitude: String?
  public var gpsPlaceEn: String?
  public var gpsSubHeadingId: String?
  public var gpsPlace: String?
  public var gpsHeadingId: String?
  public var longitude: String?

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
    latitude = json[SerializationKeys.latitude].string
    gpsPlaceEn = json[SerializationKeys.gpsPlaceEn].string
    gpsSubHeadingId = json[SerializationKeys.gpsSubHeadingId].string
    gpsPlace = json[SerializationKeys.gpsPlace].string
    gpsHeadingId = json[SerializationKeys.gpsHeadingId].string
    longitude = json[SerializationKeys.longitude].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = gpsPlaceEn { dictionary[SerializationKeys.gpsPlaceEn] = value }
    if let value = gpsSubHeadingId { dictionary[SerializationKeys.gpsSubHeadingId] = value }
    if let value = gpsPlace { dictionary[SerializationKeys.gpsPlace] = value }
    if let value = gpsHeadingId { dictionary[SerializationKeys.gpsHeadingId] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.gpsPlaceEn = aDecoder.decodeObject(forKey: SerializationKeys.gpsPlaceEn) as? String
    self.gpsSubHeadingId = aDecoder.decodeObject(forKey: SerializationKeys.gpsSubHeadingId) as? String
    self.gpsPlace = aDecoder.decodeObject(forKey: SerializationKeys.gpsPlace) as? String
    self.gpsHeadingId = aDecoder.decodeObject(forKey: SerializationKeys.gpsHeadingId) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(gpsPlaceEn, forKey: SerializationKeys.gpsPlaceEn)
    aCoder.encode(gpsSubHeadingId, forKey: SerializationKeys.gpsSubHeadingId)
    aCoder.encode(gpsPlace, forKey: SerializationKeys.gpsPlace)
    aCoder.encode(gpsHeadingId, forKey: SerializationKeys.gpsHeadingId)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
  }

}
