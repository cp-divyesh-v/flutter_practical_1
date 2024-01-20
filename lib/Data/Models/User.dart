import 'package:flutter/material.dart';

class User {
  String useId;
  String email;
  String username;
  String firstName;
  String lastName;
  String organization;
  String joinedOn;
  String about;
  String website;
  String phone;
  List<String> skills;

  User(
      {required this.useId,
      required this.email,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.organization,
      required this.joinedOn,
      required this.about,
      required this.website,
      required this.phone,
      required this.skills});

  factory User.fromJson(Map<String, dynamic> json) => User(
      useId: json["user_id"],
      email: json["email"],
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      organization: json["organization"],
      joinedOn: json["joined_on"],
      about: json["about"],
      website: json["website"],
      phone: json["phone"],
      skills: (json["skills"] as List<dynamic>).cast<String>()
  );

  Map<String, dynamic> toJson() => {
        "user_id": useId,
        "email": email,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "organization": organization,
        "joined_on": joinedOn,
        "about": about,
        "website": website,
        "phone": phone,
        "skills": skills,
      };
}

enum Interactions { follow, message, more }

extension NameOfInteractions on Interactions {
  String get name {
    switch (this) {
      case Interactions.follow:
        return 'Follow';
      case Interactions.message:
        return 'Message';
      case Interactions.more:
        return 'More';
    }
  }

  IconData get icon {
    switch (this) {
      case Interactions.follow:
        return Icons.person;
      case Interactions.message:
        return Icons.message;
      case Interactions.more:
        return Icons.more_horiz;
    }
  }
}

enum InfoOption { website, phone, email, joined }

extension NameOfInfoOptions on InfoOption {
  String get name {
    switch (this) {
      case InfoOption.website:
        return 'Website';
      case InfoOption.phone:
        return 'Phone';
      case InfoOption.email:
        return 'Email';
      case InfoOption.joined:
        return 'Joined';
    }
  }

  IconData get icon {
    switch (this) {
      case InfoOption.website:
        return Icons.web;
      case InfoOption.phone:
        return Icons.phone;
      case InfoOption.email:
        return Icons.email;
      case InfoOption.joined:
        return Icons.calendar_month;
    }
  }
}
