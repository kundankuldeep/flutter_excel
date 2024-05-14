// To parse this JSON data, do
//
//     final voterDetails = voterDetailsFromJson(jsonString);

import 'dart:convert';

VoterDetails voterDetailsFromJson(String str) => VoterDetails.fromJson(json.decode(str));

String voterDetailsToJson(VoterDetails data) => json.encode(data.toJson());

class VoterDetails {
  String? boothnumber;
  String? name;
  String? guardianname;
  String? epicnumber;
  String? gender;
  String? mobilenumber;
  String? age;
  String? caste;
  String? occupation;
  String? address;
  String? influencer;
  String? sentiment;
  String? religion;
  String? feedback;

  VoterDetails({
    this.boothnumber,
    this.name,
    this.guardianname,
    this.epicnumber,
    this.gender,
    this.mobilenumber,
    this.age,
    this.caste,
    this.occupation,
    this.address,
    this.influencer,
    this.sentiment,
    this.religion,
    this.feedback,
  });

  factory VoterDetails.fromJson(Map<String, dynamic> json) => VoterDetails(
    boothnumber: json["Boothnumber"],
    name: json["Name"],
    guardianname: json["Guardianname"],
    epicnumber: json["Epicnumber"],
    gender: json["Gender"],
    mobilenumber: json["Mobilenumber"],
    age: json["Age"],
    caste: json["Caste"],
    occupation: json["Occupation"],
    address: json["Address"],
    influencer: json["Influencer"],
    sentiment: json["Sentiment"],
    religion: json["Religion"],
    feedback: json["Feedback"],
  );

  Map<String, dynamic> toJson() => {
    "Boothnumber": boothnumber,
    "Name": name,
    "Guardianname": guardianname,
    "Epicnumber": epicnumber,
    "Gender": gender,
    "Mobilenumber": mobilenumber,
    "Age": age,
    "Caste": caste,
    "Occupation": occupation,
    "Address": address,
    "Influencer": influencer,
    "Sentiment": sentiment,
    "Religion": religion,
    "Feedback": feedback,
  };
}