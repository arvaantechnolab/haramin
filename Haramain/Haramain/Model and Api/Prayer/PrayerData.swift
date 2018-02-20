//
//  PrayerData.swift
//
//  Created by naman on 29/01/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PrayerData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sunrise = "sunrise"
    static let dhuharJamma = "dhuhar_jamma"
    static let fajrJamma = "fajr_jamma"
    static let ishaJamma = "isha_jamma"
    static let maghribJamma = "maghrib_jamma"
    static let asrJamma = "asr_jamma"
    static let date = "date"
    static let categoryId = "category_id"
    static let isha = "isha"
    static let fajr = "fajr"
    static let maghrib = "maghrib"
    static let asr = "asr"
    static let day = "day"
    static let sunriseJamma = "sunrise_jamma"
    static let dhuhar = "dhuhar"
    static let year = "year"
    static let prayerId = "prayer_id"
    static let month = "month"
  }

  // MARK: Properties
  public var sunrise: String?
  public var dhuharJamma: String?
  public var fajrJamma: String?
  public var ishaJamma: String?
  public var maghribJamma: String?
  public var asrJamma: String?
  public var date: String?
  public var categoryId: String?
  public var isha: String?
  public var fajr: String?
  public var maghrib: String?
  public var asr: String?
  public var day: String?
  public var sunriseJamma: String?
  public var dhuhar: String?
  public var year: String?
  public var prayerId: String?
  public var month: String?

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
    sunrise = json[SerializationKeys.sunrise].string
    dhuharJamma = json[SerializationKeys.dhuharJamma].string
    fajrJamma = json[SerializationKeys.fajrJamma].string
    ishaJamma = json[SerializationKeys.ishaJamma].string
    maghribJamma = json[SerializationKeys.maghribJamma].string
    asrJamma = json[SerializationKeys.asrJamma].string
    date = json[SerializationKeys.date].string
    categoryId = json[SerializationKeys.categoryId].string
    isha = json[SerializationKeys.isha].string
    fajr = json[SerializationKeys.fajr].string
    maghrib = json[SerializationKeys.maghrib].string
    asr = json[SerializationKeys.asr].string
    day = json[SerializationKeys.day].string
    sunriseJamma = json[SerializationKeys.sunriseJamma].string
    dhuhar = json[SerializationKeys.dhuhar].string
    year = json[SerializationKeys.year].string
    prayerId = json[SerializationKeys.prayerId].string
    month = json[SerializationKeys.month].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sunrise { dictionary[SerializationKeys.sunrise] = value }
    if let value = dhuharJamma { dictionary[SerializationKeys.dhuharJamma] = value }
    if let value = fajrJamma { dictionary[SerializationKeys.fajrJamma] = value }
    if let value = ishaJamma { dictionary[SerializationKeys.ishaJamma] = value }
    if let value = maghribJamma { dictionary[SerializationKeys.maghribJamma] = value }
    if let value = asrJamma { dictionary[SerializationKeys.asrJamma] = value }
    if let value = date { dictionary[SerializationKeys.date] = value }
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    if let value = isha { dictionary[SerializationKeys.isha] = value }
    if let value = fajr { dictionary[SerializationKeys.fajr] = value }
    if let value = maghrib { dictionary[SerializationKeys.maghrib] = value }
    if let value = asr { dictionary[SerializationKeys.asr] = value }
    if let value = day { dictionary[SerializationKeys.day] = value }
    if let value = sunriseJamma { dictionary[SerializationKeys.sunriseJamma] = value }
    if let value = dhuhar { dictionary[SerializationKeys.dhuhar] = value }
    if let value = year { dictionary[SerializationKeys.year] = value }
    if let value = prayerId { dictionary[SerializationKeys.prayerId] = value }
    if let value = month { dictionary[SerializationKeys.month] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.sunrise = aDecoder.decodeObject(forKey: SerializationKeys.sunrise) as? String
    self.dhuharJamma = aDecoder.decodeObject(forKey: SerializationKeys.dhuharJamma) as? String
    self.fajrJamma = aDecoder.decodeObject(forKey: SerializationKeys.fajrJamma) as? String
    self.ishaJamma = aDecoder.decodeObject(forKey: SerializationKeys.ishaJamma) as? String
    self.maghribJamma = aDecoder.decodeObject(forKey: SerializationKeys.maghribJamma) as? String
    self.asrJamma = aDecoder.decodeObject(forKey: SerializationKeys.asrJamma) as? String
    self.date = aDecoder.decodeObject(forKey: SerializationKeys.date) as? String
    self.categoryId = aDecoder.decodeObject(forKey: SerializationKeys.categoryId) as? String
    self.isha = aDecoder.decodeObject(forKey: SerializationKeys.isha) as? String
    self.fajr = aDecoder.decodeObject(forKey: SerializationKeys.fajr) as? String
    self.maghrib = aDecoder.decodeObject(forKey: SerializationKeys.maghrib) as? String
    self.asr = aDecoder.decodeObject(forKey: SerializationKeys.asr) as? String
    self.day = aDecoder.decodeObject(forKey: SerializationKeys.day) as? String
    self.sunriseJamma = aDecoder.decodeObject(forKey: SerializationKeys.sunriseJamma) as? String
    self.dhuhar = aDecoder.decodeObject(forKey: SerializationKeys.dhuhar) as? String
    self.year = aDecoder.decodeObject(forKey: SerializationKeys.year) as? String
    self.prayerId = aDecoder.decodeObject(forKey: SerializationKeys.prayerId) as? String
    self.month = aDecoder.decodeObject(forKey: SerializationKeys.month) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(sunrise, forKey: SerializationKeys.sunrise)
    aCoder.encode(dhuharJamma, forKey: SerializationKeys.dhuharJamma)
    aCoder.encode(fajrJamma, forKey: SerializationKeys.fajrJamma)
    aCoder.encode(ishaJamma, forKey: SerializationKeys.ishaJamma)
    aCoder.encode(maghribJamma, forKey: SerializationKeys.maghribJamma)
    aCoder.encode(asrJamma, forKey: SerializationKeys.asrJamma)
    aCoder.encode(date, forKey: SerializationKeys.date)
    aCoder.encode(categoryId, forKey: SerializationKeys.categoryId)
    aCoder.encode(isha, forKey: SerializationKeys.isha)
    aCoder.encode(fajr, forKey: SerializationKeys.fajr)
    aCoder.encode(maghrib, forKey: SerializationKeys.maghrib)
    aCoder.encode(asr, forKey: SerializationKeys.asr)
    aCoder.encode(day, forKey: SerializationKeys.day)
    aCoder.encode(sunriseJamma, forKey: SerializationKeys.sunriseJamma)
    aCoder.encode(dhuhar, forKey: SerializationKeys.dhuhar)
    aCoder.encode(year, forKey: SerializationKeys.year)
    aCoder.encode(prayerId, forKey: SerializationKeys.prayerId)
    aCoder.encode(month, forKey: SerializationKeys.month)
  }

}
