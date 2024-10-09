import '../../../utility/parsing_helper.dart';

class TripResponse {
  final bool success;
  final String message;
  final Trip data;

  TripResponse({
    this.success = false,
    this.message = "",
    required this.data,
  });

  factory TripResponse.fromJson(Map<String, dynamic>? json) => TripResponse(
    success: asBool(json, 'success'),
    message: asString(json, 'message'),
    data: Trip.fromJson(asMap(json, 'data')),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class Trip {
  final String pickUpLatitude;
  final String pickUpLongitude;
  final String pickUpCity;
  final String destinationLatitude;
  final String destinationLongitude;
  final String destinationCity;
  final String departureDate;
  final String departureTime;
  final String arrivalDate;
  final String arrivalTime;
  final String carId;
  final String numOfSeats;
  final String tripPrice;
  final String frontChairPrice;
  final int userId;
  final String updatedAt;
  final String createdAt;
  final int id;

  Trip({
    this.pickUpLatitude = "",
    this.pickUpLongitude = "",
    this.pickUpCity = "",
    this.destinationLatitude = "",
    this.destinationLongitude = "",
    this.destinationCity = "",
    this.departureDate = "",
    this.departureTime = "",
    this.arrivalDate = "",
    this.arrivalTime = "",
    this.carId = "",
    this.numOfSeats = "",
    this.tripPrice = "",
    this.frontChairPrice = "",
    this.userId = 0,
    this.updatedAt = "",
    this.createdAt = "",
    this.id = 0,
  });

  factory Trip.fromJson(Map<String, dynamic>? json) => Trip(
    pickUpLatitude: asString(json, 'pick_up_latitude'),
    pickUpLongitude: asString(json, 'pick_up_longitude'),
    pickUpCity: asString(json, 'pick_up_city'),
    destinationLatitude: asString(json, 'destination_latitude'),
    destinationLongitude: asString(json, 'destination_longitude'),
    destinationCity: asString(json, 'destination_city'),
    departureDate: asString(json, 'departure_date'),
    departureTime: asString(json, 'departure_time'),
    arrivalDate: asString(json, 'arrival_date'),
    arrivalTime: asString(json, 'arrival_time'),
    carId: asString(json, 'car_id'),
    numOfSeats: asString(json, 'num_of_seats'),
    tripPrice: asString(json, 'trip_price'),
    frontChairPrice: asString(json, 'front_chair_price'),
    userId: asInt(json, 'user_id'),
    updatedAt: asString(json, 'updated_at'),
    createdAt: asString(json, 'created_at'),
    id: asInt(json, 'id'),
  );

  Map<String, dynamic> toJson() => {
    'pick_up_latitude': pickUpLatitude,
    'pick_up_longitude': pickUpLongitude,
    'pick_up_city': pickUpCity,
    'destination_latitude': destinationLatitude,
    'destination_longitude': destinationLongitude,
    'destination_city': destinationCity,
    'departure_date': departureDate,
    'departure_time': departureTime,
    'arrival_date': arrivalDate,
    'arrival_time': arrivalTime,
    'car_id': carId,
    'num_of_seats': numOfSeats,
    'trip_price': tripPrice,
    'front_chair_price': frontChairPrice,
    'user_id': userId,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
  };
}

