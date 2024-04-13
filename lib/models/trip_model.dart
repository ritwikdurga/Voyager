import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  late String tripId;
  late String title;
  late String location;
  late DateTime startDate;
  late DateTime endDate;
  String? bgImageURL;
  bool isBookmarked;

  Trip({
    required this.tripId,
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.bgImageURL,
    required this.isBookmarked,
  });

  factory Trip.fromFirestore(DocumentSnapshot doc, bool bookmarked) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return Trip(
      tripId: doc.id,
      title: data?['title'] ?? 'No Title',
      location: data?['location'] ?? 'NaN',
      startDate: data?['startDate'] != null
          ? (data?['startDate']).toDate()
          : DateTime.now(),
      endDate: data?['endDate'] != null
          ? (data?['endDate']).toDate()
          : DateTime.now(),
      bgImageURL: data?['bg_image_url'] ?? 'No Image URL',
      isBookmarked: bookmarked,
    );
  }
}
