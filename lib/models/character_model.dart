import 'package:flutter/material.dart';

class Character {
  final String id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String origin;
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id']?.toString() ?? '0',
      name: json['name'] ?? 'Desconocido',
      status: json['status'] ?? 'unknown',
      species: json['species'] ?? 'unknown',
      type: json['type'] ?? '',
      gender: json['gender'] ?? 'unknown',
      image: json['image'] ?? '',
      origin: json['origin']?['name'] ?? 'unknown',
      location: json['location']?['name'] ?? 'unknown',
    );
  }

  int get simulatedUserId {
    return id.hashCode.abs() % 10 + 1;
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
