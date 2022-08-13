
class WeatherData {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final double? pressure;
  final double? humidity;

  const WeatherData({
     this.temp,
     this.feelsLike,
     this.tempMin,
     this.tempMax,
     this.pressure,
     this.humidity,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temp: double.parse(json['temp'].toString()),
      feelsLike: double.parse(json['feels_like'].toString()),
      tempMin: double.parse(json['temp_min'].toString()),
      tempMax: double.parse(json['temp_max'].toString()),
      pressure: double.parse(json['pressure'].toString()),
      humidity: double.parse(json['humidity'].toString()),
    );
  }
}