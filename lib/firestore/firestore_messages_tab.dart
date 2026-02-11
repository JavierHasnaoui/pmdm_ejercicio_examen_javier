import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/message.dart';
import 'edit_message_page.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final TextEditingController _controller = TextEditingController();

  // ENVIAR MENSAJE AL FIRESTORE DATABASE A LA COLECCION DE MESSAGES.
  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _controller.text.trim().isEmpty) return;

    await FirebaseFirestore.instance.collection('messages').add({
      'userEmail': user.email,
      'text': _controller.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      children: [
        // Lista de mensajes
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No hay mensajes'));
              }

              // Esto es de la entities.
              final docs = snapshot.data!.docs;

              return ListView.builder(
                reverse: true, // Para que los mensajes nuevos aparezcan abajo
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  // De FIRESTORE Muestra los datos en la APP.
                  final message = Message.fromFirestore(docs[index]);
                  // Que el usermail es lo mismo que email.
                  final isMine = message.userEmail == user?.email;
                  // Para mostrar el mensaje y el email.
                  return ListTile(
                    title: Text(message.text),
                    subtitle: Text(message.userEmail),
                    trailing: isMine
                        ?
                        // Esto es el boton de editar.
                      IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditMessagePage(
                              message: message,
                            ),
                          ),
                        );
                      },
                    )
                        : null,
                  );
                },
              );
            },
          ),
        ),

        // TextField + botón para enviar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Escribe un mensaje',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
