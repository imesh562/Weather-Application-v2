// Data model to display data in home screen main card.
class Current {
  int? temperature;
  int? feelsLike;
  double? windSpeed;
  String? weatherIcon;
  String? weatherText;
  double? indexUV;
  int? pressure;
  String? today;

  Current({
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.weatherIcon,
    required this.weatherText,
    required this.indexUV,
    required this.pressure,
    required this.today,
  });
}
