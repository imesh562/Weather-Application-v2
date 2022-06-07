import 'package:intl/intl.dart';
import '../models/daily.dart';

class NextDaysController {
  List<Daily> dailyData = [];

  // Update the data in Next 7 Days data in 2nd screen.
  List<Daily> updateUI(dynamic weatherData) {
    for (var i = 1; i < 8; i++) {
      var millis = weatherData['daily'][i]['dt'];
      millis = int.parse(millis.toString() + '000');
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var day = DateFormat.E().format(dt);
      var date = DateFormat.MMMd().format(dt);

      // ignore: prefer_typing_uninitialized_variables
      var daillyTemp;
      if (weatherData['daily'][i]['temp']['day'].runtimeType == double) {
        var temp = weatherData['daily'][i]['temp']['day'];
        daillyTemp = temp.toInt();
      } else {
        daillyTemp = weatherData['daily'][i]['temp']['day'];
      }
      var tempFeels = weatherData['daily'][i]['feels_like']['day'];
      var feelsLike = tempFeels.toInt();
      dailyData.add(
        Daily(
          id: weatherData['daily'][i]['weather'][0]['id'],
          day: day,
          date: date,
          temp: daillyTemp.toString(),
          tempFeels: feelsLike.toString() + '°',
        ),
      );
    }
    return dailyData;
  }
}
