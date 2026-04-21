class BookingModel {
  final String id;
  final String eventId;
  final String eventName;
  final int seats;
  final String userId;

  BookingModel({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.seats,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'seats': seats,
      'userId': userId,
    };
  }

  BookingModel.fromJson(String docId,Map<String, dynamic> d)
    : id = docId,
      eventId = d['eventId'],
      eventName = d['eventName'],
      seats = d['seats'],
      userId = d['userId'];
}
