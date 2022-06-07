import 'package:weather_app_assignment/services/location.dart';
import 'package:weather_app_assignment/services/networking.dart';

const apiKey = '72eeebf297d3483114af9797ad49fb76';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/onecall';

class WeatherModel {
  // This method is used to connect to the API.
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,alerts&units=metric&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  // Returns the corresponding weather Icon on call.
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
