import 'package:astronomy_event_booking/models/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final List<EventModel> events = <EventModel>[
    EventModel(
      id: '1',
      name: 'Solar Eclipse Viewing',
      date: 'May 12, 2025',
      location: 'Jaipur, Rajasthan',
      description:
          'Witness a rare total solar eclipse with expert astronomers guiding you through the event. Telescopes and safety glasses provided.',
      availableSeats: 30,
      imageUrl:
          'https://images.unsplash.com/photo-1532667449560-72a95c8d381b?w=800',
    ),
    EventModel(
      id: '2',
      name: 'Meteor Shower Night',
      date: 'June 3, 2025',
      location: 'Rann of Kutch, Gujarat',
      description:
          'Experience the Perseid meteor shower from one of India\'s darkest skies. Includes bonfire and overnight camping.',
      availableSeats: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
    ),
    EventModel(
      id: '3',
      name: 'Moon Gazing Session',
      date: 'June 15, 2025',
      location: 'Nainital, Uttarakhand',
      description:
          'A guided moon gazing session with high-powered telescopes at the Aryabhatta Research Institute.',
      availableSeats: 15,
      imageUrl:
          'https://images.unsplash.com/photo-1446941611757-91d2c3bd3d45?w=800',
    ),
    EventModel(
      id: '4',
      name: 'Mars Opposition Night',
      date: 'July 20, 2025',
      location: 'Leh, Ladakh',
      description:
          'Mars will be at its closest to Earth. Join us for an exclusive viewing session with expert commentary.',
      availableSeats: 25,
      imageUrl:
          'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800',
    ),
    EventModel(
      id: '5',
      name: 'Milky Way Photography',
      date: 'August 8, 2025',
      location: 'Spiti Valley, Himachal',
      description:
          'Learn astrophotography while capturing the Milky Way. Camera equipment guidance provided by professionals.',
      availableSeats: 10,
      imageUrl:
          'https://images.unsplash.com/photo-1506443432602-ac2fcd6f54e0?w=800',
    ),
    EventModel(
      id: '6',
      name: 'Jupiter & Saturn Watch',
      date: 'September 1, 2025',
      location: 'Pune, Maharashtra',
      description:
          'See Jupiter\'s moons and Saturn\'s rings up close through our professional-grade telescopes.',
      availableSeats: 40,
      imageUrl:
          'https://images.unsplash.com/photo-1545156521-77bd85671d30?w=800',
    ),
  ];
}
