import 'package:flutter/material.dart';
import 'package:weather_app_assignment/controllers/next_days_controller.dart';
import '../models/daily.dart';
import '../services/weather.dart';

// ignore: must_be_immutable
class NextDays extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;
  // ignore: prefer_typing_uninitialized_variables
  final locationCountry;
  // ignore: prefer_typing_uninitialized_variables
  final locationCity;

  // ignore: use_key_in_widget_constructors
  const NextDays(
      {this.locationCity, this.locationCountry, this.locationWeather});

  @override
  State<NextDays> createState() => _NextDaysState();
}

class _NextDaysState extends State<NextDays> {
  List<Daily> dailyData = [];
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    NextDaysController nxtDays = NextDaysController();
    dailyData = nxtDays.updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: widget.locationCity + ', ',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.locationCountry,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.75),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 20.0,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.025,
              left: width * 0.05,
              bottom: height * 0.025,
            ),
            child: const Text(
              "Next 7 Days",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dailyData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 25.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        weather.getWeatherIcon(dailyData[index].id!),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: RichText(
                            text: TextSpan(
                              text: dailyData[index].day! + ', ',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: dailyData[index].date!,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withOpacity(0.75),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                            text: dailyData[index].temp! + '/ ',
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: dailyData[index].tempFeels!,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white.withOpacity(0.75),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
