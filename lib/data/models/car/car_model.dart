class Car {
  final int id;
  final String brand;
  final int seatsNumber;

  Car({required this.id, required this.brand, required this.seatsNumber});

  // Factory constructor to create a Car from JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      seatsNumber: json['seats_number'],
    );
  }
}