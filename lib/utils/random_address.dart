import 'dart:math';

class AddressGenerator {
  static final Random _random = Random();

  static final List<String> _streetNames = [
    "Main St",
    "Maple Ave",
    "Oak Dr",
    "Pine St",
    "Elm St",
    "Cedar Blvd",
    "Birch Ave",
    "Willow Ln",
    "Chestnut St",
    "Park Ave"
  ];

  static final List<String> _cities = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Philadelphia",
    "San Antonio",
    "San Diego",
    "Dallas",
    "San Jose"
  ];

  static String _generateRandomStreetNumber() {
    return "${_random.nextInt(8999) + 1000}"; // Random number between 1000 and 9999
  }

  static String generateRandomAddress() {
    String streetNumber = _generateRandomStreetNumber();
    String streetName = _streetNames[_random.nextInt(_streetNames.length)];
    String city = _cities[_random.nextInt(_cities.length)];

    return "$streetNumber $streetName, $city,";
  }
}
