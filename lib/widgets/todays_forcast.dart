import 'package:flutter/material.dart';
import 'package:weather_app_assignment/models/hourly.dart';
import 'package:weather_app_assignment/services/weather.dart';

// ignore: must_be_immutable
class TodaysForcast extends StatelessWidget {
  final List<Hourly> hourlyData;
  WeatherModel weather = WeatherModel();
  // ignore: use_key_in_widget_constructors
  TodaysForcast(this.hourlyData);

  _buildRecentOrder(BuildContext context, index) {
    int id = hourlyData.elementAt(index).id!;
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 60.0,
      decoration: BoxDecoration(
        color: index == 0 ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 0.5,
          color: Colors.grey.shade400,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hourlyData.elementAt(index).time.toString(),
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: index == 0 ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              weather.getWeatherIcon(id),
              style: TextStyle(
                fontSize: 30,
                color: index == 0 ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              hourlyData.elementAt(index).temp!,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: index == 0 ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: hourlyData.length,
        itemBuilder: (BuildContext context, index) {
          return _buildRecentOrder(context, index);
        },
      ),
    );
  }
}
