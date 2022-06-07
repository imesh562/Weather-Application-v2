import 'package:flutter/material.dart';
import 'package:weather_app_assignment/models/current.dart';
import 'package:weather_app_assignment/models/hourly.dart';
import 'package:weather_app_assignment/screens/next_days.dart';
import '../controllers/home_screen_controller.dart';
import '../widgets/todays_forcast.dart';
import '../widgets/weather_info.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({this.locationWeather});
  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Current> currentData = [];
  List<Hourly> hourlyData = [];
  List location = ['', ''];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    awaitList();
  }

  awaitList() async {
    CurrentController currentHomeData = CurrentController();
    setState(() {
      currentData = currentHomeData.updateUI(widget.locationWeather);
      hourlyData = currentHomeData.updateUIHourly(widget.locationWeather);
    });
    var tempLocation = await currentHomeData.getAddressFromLatLong();
    setState(() {
      location = tempLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: width * 0.02,
                left: width * 0.02,
                top: height * 0.035,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.drag_handle_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                    iconSize: 30.0,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                    iconSize: 30.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: RichText(
                text: TextSpan(
                  text: location[0] + ', ',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: location[1],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.2,
                        color: Colors.black.withOpacity(0.75),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.symmetric(
                vertical: height * 0.03,
                horizontal: width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                        ),
                        child: Text(
                          currentData[0].weatherIcon!,
                          style: const TextStyle(
                            fontSize: 65,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        currentData[0].weatherText!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(
                        height: 7.5,
                      ),
                      Text(
                        currentData[0].today!,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        currentData[0].temperature!.toString() + '°',
                        style: const TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      weatherInfo('assets/Images/Icons/wind.png', "WIND",
                          currentData[0].windSpeed!, "top_left"),
                      weatherInfo(
                          'assets/Images/Icons/tempereture.png',
                          "FEELS LIKE",
                          currentData[0].feelsLike!.toString() + '°',
                          "top_right"),
                    ],
                  ),
                  Row(
                    children: [
                      weatherInfo('assets/Images/Icons/sun.png', "INDEX UV",
                          currentData[0].indexUV!, "bottom_left"),
                      weatherInfo(
                          'assets/Images/Icons/pressure.png',
                          "PRESSURE",
                          currentData[0].pressure!.toString() + " mbar",
                          "bottom_right"),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                  ),
                  child: const Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.05,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NextDays(
                          locationWeather: widget.locationWeather,
                          locationCity: location[0],
                          locationCountry: location[1],
                        );
                      }));
                    },
                    child: Text(
                      "Next 7 Days   >",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.6),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TodaysForcast(hourlyData)
          ],
        ),
      ),
    );
  }
}
