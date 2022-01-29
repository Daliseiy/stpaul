class Testimony {
  final String id;
  final String name;
  final String phoneNumber;
  final String testimony;
  bool isVisible = true;

  Testimony(
      this.id, this.name, this.phoneNumber, this.testimony, this.isVisible);
}

class Contact {
  final String name;
  final String phoneNumber;
  final String email;
  final String message;

  Contact(this.name, this.phoneNumber, this.email, this.message);
}

class Event {
  final String id;
  final String title;
  final String date;
  final String time;

  Event(this.id, this.title, this.date, this.time);
}
