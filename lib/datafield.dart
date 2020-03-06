enum DataField {
  // Non-realtime Values
  Alkalinity,
  Ammonia,
  Chlorine,
  Nitrate,

  // Realtime Values
  WaterLevelAquarium,   
  WaterLevelTank,
  WaterTemp,
  AirTemp,
  AirHumidity,
  Feeds,
}

const Map<DataField, String> DataFieldStrings = {
  DataField.Alkalinity:         "Alkalinity",
  DataField.Ammonia:            "Ammonia",
  DataField.Chlorine:           "Chlorine",
  DataField.Nitrate:            "Nitrate",
  DataField.WaterLevelAquarium: "Water Level Aquarium",
  DataField.WaterLevelTank:     "Water Level Tank",
  DataField.WaterTemp:          "Water Temperature",
  DataField.AirTemp:            "Air Temperature",
  DataField.AirHumidity:        "Air Humidity",
  DataField.Feeds:              "Remaining Feeds",
};

const Map<DataField, String> DataFieldSuffixes = {
  DataField.Alkalinity:         "pH",
  DataField.Ammonia:            "ppm",
  DataField.Chlorine:           "ppm",
  DataField.Nitrate:            "ppm",
  DataField.WaterLevelAquarium: "%",
  DataField.WaterLevelTank:     "%",
  DataField.WaterTemp:          "°C",
  DataField.AirTemp:            "°C",
  DataField.AirHumidity:        "%",
  DataField.Feeds:              "%",
};