import 'package:flutter/material.dart';

Widget weatherInfo(imageURL, title, value, position) {
  return Expanded(
    flex: 1,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff83A9FF),
          ),
          borderRadius: position == "bottom_left"
              ? const BorderRadius.only(bottomLeft: Radius.circular(25.0))
              : position == "bottom_right"
                  ? const BorderRadius.only(bottomRight: Radius.circular(25.0))
                  : null),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
              width: 35.0,
              fit: BoxFit.cover,
              image: AssetImage(imageURL),
              color: Colors.white,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
