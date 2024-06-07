import 'package:real_estate_app/core/enums/gender.dart';

class UserDetails {
  final String name;
  final String email;
  final String password;
  final String? phoneNum;
  final String? image;
  final String? address;
  final String? bio;
  final DateTime? dateofBirth;
  final Gender? gender;

  UserDetails({
    required this.name,
    required this.email,
    required this.password,
    this.phoneNum,
    this.image,
    this.address,
    this.bio,
    this.dateofBirth,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNum': phoneNum,
      'image': image,
      'address': address,
      'bio': bio,
      'dateofBirth': dateofBirth?.toIso8601String(),
      'gender': gender?.toString(),
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['UserDetails.name'],
      email: map['UserDetails.email'],
      password: map['password'],
      phoneNum: map['phoneNum'],
      image: map['image'],
      address: map['address'],
      bio: map['bio'],
      dateofBirth: map['dateofBirth'] != null
          ? DateTime.parse(map['dateofBirth'])
          : null,
      gender: Gender.toGender(map['gender']),
    );
  }
}
