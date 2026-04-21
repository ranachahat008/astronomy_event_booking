class EventModel {
  final String id;
  final String name;
  final String description;
  final String date;
  final String location;
  final int availableSeats;
  final int totalSeats;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.availableSeats,
    required this.imageUrl,
    required this.totalSeats,
  });

  EventModel.fromJson(Map<String, dynamic> d)
    : id = d['id'],
      name = d['name'],
      description = d['description'],
      date = d['date'],
      location = d['location'],
      availableSeats = d['availableSeats'],
      totalSeats = d['totalSeats'],
      imageUrl = d['imageUrl'];
}
