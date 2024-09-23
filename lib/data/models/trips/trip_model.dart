class TripModel {
  final double pickUpLatitude;
  final double pickUpLongitude;
  final String pickUpCity;
  final double destinationLatitude;
  final double destinationLongitude;
  final String destinationCity;
  final String departureDate;
  final String departureTime;
  final String arrivalDate;
  final String arrivalTime;
  final int carId;
  final int numOfSeats;
  final double tripPrice;
  final double frontChairPrice;

  TripModel({
    required this.pickUpLatitude,
    required this.pickUpLongitude,
    required this.pickUpCity,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.destinationCity,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.carId,
    required this.numOfSeats,
    required this.tripPrice,
    required this.frontChairPrice,
  });

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}