import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Offer {
  final String? id;
  final double? offeredMoney;
  final double? settledMoney;
  final String? statement;
  final String title;
  final String createdBy;
  final String senderName;
  final String senderEmail;
  final String sentTo;
  final OfferStatus offerStatus;
  final OfferPurpose purpose;
  final DateTime createdAt;

  Offer({
    this.offeredMoney,
    this.settledMoney,
    this.statement,
    required this.id,
    required this.senderName,
    required this.title,
    required this.senderEmail,
    required this.createdBy,
    required this.createdAt,
    required this.sentTo,
    required this.offerStatus,
    required this.purpose,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'offeredMoney': offeredMoney,
      'title': title,
      'settledMoney': settledMoney,
      'statement': statement,
      'createdBy': createdBy,
      'createdAt': createdAt.toString(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'sentTo': sentTo,
      'offerStatus': offerStatus.name.toString(),
      'purpose': purpose.name.toString(),
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      offeredMoney: map['offeredMoney'] ?? 0.0,
      settledMoney: map['settledMoney'] ?? 0.0,
      statement: map['statement'] ?? "",
      createdBy: map['createdBy'] ?? "",
      senderEmail: map['senderEmail'] ?? "",
      senderName: map['senderName'] ?? "",
      sentTo: map['sentTo'] ?? "",
      createdAt: DateTime.parse(map['createdAt'] ?? ""),
      offerStatus: OfferStatus.toOfferStatus(map['offerStatus']),
      purpose: OfferPurpose.toOfferPurpose(map['purpose']),
    );
  }
}

enum OfferStatus {
  accepted,
  rejected,
  pending;

  static OfferStatus toOfferStatus(String str) {
    return OfferStatus.values.firstWhere((element) => element.name == str);
  }
}

enum OfferPurpose {
  visit,
  buy;

  static OfferPurpose toOfferPurpose(String str) {
    return OfferPurpose.values.firstWhere((element) => element.name == str);
  }
}
