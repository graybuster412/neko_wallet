

import '../shared/shared.dart';

class NotificationModel {
  String title;
  NotificationType type;
  String? content;
  bool isChecked;

  NotificationModel({
    required this.title,
    this.content,
    required this.type,
    this.isChecked: false,
  });


  String? getFirstWord() {
    if (content != null && content?.trim().isNotEmpty == true) {
      return content?.split(" ").first ?? "";
    }
    return null;
  }

  String? getRestOfContent() {
    if (content != null && content?.trim().isNotEmpty == true) {
      List<String> array = content!.split(" ");
      
      // Remove first word
      array.removeAt(0);

      return array.join(" ");
    }
    return null;
  }
}
