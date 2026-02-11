import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String userEmail;
  final String text;
  final Timestamp? timestamp;
  final bool edited;

  Message({
    required this.id,
    required this.userEmail,
    required this.text,
    required this.timestamp,
    required this.edited,
  });

  // Convertir Firestore → Message
  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Message(
      id: doc.id,
      userEmail: data['userEmail'] ?? '',
      text: data['text'] ?? '',
      timestamp: data['timestamp'],
      edited: data['edited'] ?? false,
    );
  }

  // Convertir Message → Map (para guardar)
  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'text': text,
      'timestamp': timestamp,
      'edited': edited,
    };
  }
}
