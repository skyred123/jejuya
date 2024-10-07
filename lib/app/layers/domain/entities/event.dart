/// Represent type of the event's id
typedef EventId = int;

/// Entity representing an Event
class Event {
  /// Constructor for the Event entity
  Event({
    required this.title,
  });

  /// Title of the event
  final String title;
}
