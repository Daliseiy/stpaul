import 'package:flutter/material.dart';

class LinkItem {
  final String text;
  final IconData icon;
  final Color color;
  final String routes;

  LinkItem(this.text, this.icon, this.color, this.routes);
}

List<LinkItem> links = [
  LinkItem('Testimonies', Icons.surround_sound, Colors.pinkAccent.shade200,
      'testimony-admin'),
  LinkItem('Events', Icons.event, Colors.teal.shade300, 'event-admin'),
  LinkItem(
      'Contacts', Icons.contact_page, Colors.purple.shade300, 'contact-admin'),
  LinkItem(
      'Burials', Icons.wb_iridescent, Colors.lime.shade400, 'burial-admin'),
  LinkItem(
      'Occassions', Icons.party_mode, Colors.red.shade300, 'occassion-admin'),
];
