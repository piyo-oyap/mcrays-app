enum DataField {
  Alkalinity,
  Ammonia,
  Chlorine,
  Nitrate,
  WaterLevelAquarium,
  WaterLevelTank,
  WaterTemp,
  AirTemp,
  AirHumidity,
  Feeds,
}

const Map<DataField, String> DataFieldStrings = {
  DataField.Alkalinity: "Alkalinity",
  DataField.Ammonia: "Ammonia",
  DataField.Chlorine: "Chlorine",
  DataField.Nitrate: "Nitrate",
  DataField.WaterLevelAquarium: "Water Level Aquarium",
  DataField.WaterLevelTank: "Water Level Tank",
  DataField.WaterTemp: "Water Temperature",
  DataField.AirTemp: "Air Temperature",
  DataField.AirHumidity: "Air Humidity",
  DataField.Feeds: "Feeds",
};