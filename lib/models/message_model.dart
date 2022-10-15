import '../models/user_model.dart';

class Message {
  final UserModel sender;
  int time; // Timestamp
  String? text;
  bool isLiked;
  bool unread;

  Message({
    required this.sender,
    required this.time,
    this.text,
    this.isLiked: false,
    this.unread: false,
  });
}

// YOU - current UserModel
final UserModel currentUser =
    UserModel(id: '0', name: 'Kelvin Pham', imageUrl: 'assets/images/greg.jpg');

// USERS
final UserModel greg =
    UserModel(id: '1', name: 'Greg', imageUrl: 'assets/images/greg.jpg');
final UserModel james =
    UserModel(id: '2', name: 'James', imageUrl: 'assets/images/james.jpg');
final UserModel john =
    UserModel(id: '3', name: 'John', imageUrl: 'assets/images/john.jpg');
final UserModel olivia =
    UserModel(id: '4', name: 'Olivia', imageUrl: 'assets/images/olivia.jpg');
final UserModel sam =
    UserModel(id: '5', name: 'Sam', imageUrl: 'assets/images/sam.jpg');
final UserModel sophia =
    UserModel(id: '6', name: 'Sophia', imageUrl: 'assets/images/sophia.jpg');
final UserModel steven =
    UserModel(id: '7', name: 'Steven', imageUrl: 'assets/images/steven.jpg');

// FAVORITE CONTACTS
List<UserModel> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: DateTime.now().millisecond,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: DateTime.now().subtract(Duration(days: 4)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: DateTime.now().subtract(Duration(days: 6)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch,
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: DateTime.now().subtract(Duration(days: 8)).millisecondsSinceEpoch,
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
