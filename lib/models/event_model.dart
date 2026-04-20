class EventModel {
  final String id;
  final String name;
  final String description;
  final String date;
  final String location;
  final int availableSeats;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.availableSeats,
    required this.imageUrl
});
}
