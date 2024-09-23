class Trip {
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

  Trip({
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
}