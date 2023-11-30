import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  File image;

  Place({required this.title, required this.image}) : id = uuid.v4();
}
