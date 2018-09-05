import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EventItem {
  EventItem(
      this.title,
      this.body,
      this.imageUrl,
      this.date,
      this.venue,
      this.adminId
      );

  String key;
  String title;
  String body;
  String imageUrl;
  String date;
  String adminId;
  String venue;

  EventItem.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        title = snapshot.value['title'],
        body = snapshot.value['body'],
        imageUrl = snapshot.value['imageUrl'],
        adminId = snapshot.value['adminId'],
        date = snapshot.value['date'],
        venue = snapshot.value['venue'];

  toJson() {
    return {
      "title" : title,
      "body" : body,
      "imageUrl" : imageUrl,
      "date" : date,
      "adminId" : adminId,
      "venue" : venue,
    };
  }
}