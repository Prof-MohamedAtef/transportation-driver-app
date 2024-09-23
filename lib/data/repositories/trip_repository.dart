// import 'package:zeow/domain/etities/trip.dart';
// import 'package:sqflite/sqflite.dart';

// class TripRepository {
//   Database database;

//   TripRepository({required this.database});

//   Future<void> insertTrip(TripEntity trip) async {
//     await database.insert('trips', trip.toJson());
//   }

//   Future<List<TripEntity>> getTrips() async {
//     final List<Map<String, dynamic>> maps = await database.query('trips');
//     return List.generate(
//       maps.length,
//       (i) => TripEntity.fromJson(maps[i]),
//     );
//   }
// }
