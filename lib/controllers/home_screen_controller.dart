import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_assignment/models/current.dart';
import 'package:weather_app_assignment/models/hourly.dart';
import 'package:weather_app_assignment/services/weather.dart';

class CurrentController {
  // Update the data in Home screen main card.
  List<Current> updateUI(dynamic weatherData) {
    WeatherModel weather = WeatherModel();
    int? temperature;
    int? feelsLike;
    double? windSpeed;
    String? weatherIcon;
    String? weatherText;
    double? indexUV;
    int? pressure;
    String? today;
    List<Current> currentData = [];

    if (weatherData == null) {
      temperature = 0;
      feelsLike = 0;
      indexUV = 0;
      pressure = 0;
      windSpeed = 0;
      weatherIcon = '404';
      weatherText = '404';
      today = "404";
    }
    if (weatherData['current']['temp'].runtimeType == double) {
      var temp = weatherData['current']['temp'];
      temperature = temp.toInt();
    } else {
      temperature = weatherData['current']['temp'];
    }

    if (weatherData['current']['uvi'].runtimeType == int) {
      var uvi = weatherData['current']['uvi'];
      indexUV = uvi.toDouble();
    } else {
      indexUV = weatherData['current']['uvi'];
    }

    var tempFeels = weatherData['current']['feels_like'];
    feelsLike = tempFeels.toInt();

    var press = weatherData['current']['pressure'];
    pressure = press.toInt();

    windSpeed = weatherData['current']['wind_speed'];

    var condition = weatherData['current']['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(condition);

    weatherText = weatherData['current']['weather'][0]['description'];

    DateTime now = DateTime.now();
    today = DateFormat.yMMMEd().format(now);

    currentData.add(
      Current(
        temperature: temperature,
        feelsLike: feelsLike,
        windSpeed: windSpeed,
        weatherIcon: weatherIcon,
        weatherText: weatherText,
        indexUV: indexUV,
        pressure: pressure,
        today: today,
      ),
    );
    return currentData;
  }

  // Update the data in Home screen bottom hourly cards.
  List<Hourly> updateUIHourly(dynamic weatherData) {
    List<Hourly> hourlyData = [];
    for (var i = 1; i < 48; i++) {
      var millis = weatherData['hourly'][i]['dt'];
      millis = int.parse(millis.toString() + '000');
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var dtResult = DateFormat.yMMMd().format(dt);
      var dtResultTime = DateFormat.Hm().format(dt);
      var dtNow = DateFormat.yMMMd().format(DateTime.now());
      if (dtResult == dtNow) {
        // ignore: prefer_typing_uninitialized_variables
        var hourlyTemp;
        if (weatherData['hourly'][i]['temp'].runtimeType == double) {
          var temp = weatherData['hourly'][i]['temp'];
          hourlyTemp = temp.toInt();
        } else {
          hourlyTemp = weatherData['hourly'][i]['temp'];
        }
        hourlyData.add(
          Hourly(
            id: weatherData['hourly'][i]['weather'][0]['id'],
            temp: hourlyTemp.toString() + '°',
            time: dtResultTime,
          ),
        );
      }
    }
    return hourlyData;
  }

  // Update the data in Home screen location name.
  Future<List<String>> getAddressFromLatLong() async {
    String city = "404";
    String country = "404";
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    city = place.locality!;
    country = place.country!;
    return [city, country];
  }
}
