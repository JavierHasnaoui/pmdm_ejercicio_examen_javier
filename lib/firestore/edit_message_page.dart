import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/message.dart';

class EditMessagePage extends StatefulWidget {
  final Message message;

  const EditMessagePage({super.key, required this.message,});

  @override
  State<EditMessagePage> createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message.text);
  }
  // PARA ELIMINAR
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar mensaje'),
          content: const Text('¿Seguro que quieres eliminar este mensaje?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('messages')
                    .doc(widget.message.id)
                    .delete();

                Navigator.pop(context); // cerrar dialog
                Navigator.pop(context); // volver al chat
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
  // PARA ACTUALIZAR EL MENSAJE
  Future<void> _updateMessage() async {
    final newText = _controller.text.trim();
    if (newText.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('messages')
        .doc(widget.message.id)
        .update({
      'text': newText,
      'edited': true,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar mensaje'),
        actions: [
          // BOTON CONFIRMAR ELIMINAR
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateMessage,
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
