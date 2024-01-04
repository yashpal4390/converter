import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactModal {
  String? name;
  String? number;
  String? chat;
  DateTime? selectdate;
  TimeOfDay? selecttime;
  XFile? xFile;

  ContactModal({
    this.name,
    this.number,
    this.chat,
    this.selectdate,
    this.selecttime,
    this.xFile,
  });

  factory ContactModal.fromJson(Map<String, dynamic> json) {
    return ContactModal(
      name: json['name'],
      number: json['number'],
      chat: json['chat'],
      selectdate: json['selectdate'] != null ? DateTime.parse(json['selectdate']) : null,
      selecttime: json['selecttime'] != null
          ? TimeOfDay(
        hour: int.parse(json['selecttime'].split(":")[0]),
        minute: int.parse(json['selecttime'].split(":")[1]),
      )
          : null,
      xFile: json['xFile'] != null ? XFile(json['xFile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'chat': chat,
      'selectdate': selectdate?.toIso8601String(),
      'selecttime': selecttime != null ? '${selecttime!.hour}:${selecttime!.minute}' : null,
      'xFile': xFile?.path,
    };
  }
}
