import 'package:flutter/material.dart';
import 'package:neko_wallet/models/user_model.dart';

class Contact extends UserModel {
  Contact({id, name, imageURL, this.isSelected: false})
      : super(id: id, name: name, imageUrl: imageURL);

  bool isSelected;

  String? get firstLetterOfName {
    return name?.characters.first.toString();
  }
}
