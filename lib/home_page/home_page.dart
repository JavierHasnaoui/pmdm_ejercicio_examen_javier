import 'package:flutter/material.dart';
import 'package:pmdm_ejercicio_examen/firestore/firestore_messages_tab.dart';
import '../drawer/drawer.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Contenido de cada tab
  final List<Widget> _tabs = [
    const Center(child: Text('Tab 1: Inicio')),
    const MessagesTab(),
    const Center(child: Text('Tab 3: Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: const AppDrawer(), // Drawer incluido
      body: _tabs[_currentIndex], // Muestra la tab actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambiar tab
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
