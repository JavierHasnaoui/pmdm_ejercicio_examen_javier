import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryPage extends StatefulWidget {
  const ImageGalleryPage({super.key});

  @override
  State<ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  String? _imagePath;
  String? _imageName;
  int? _imageSize;
  int? _imageWidth;
  int? _imageHeight;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();

    // obtener imagen de la galería
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 90,
    );

    // si no ha seleccionado nada => salir
    if (xFile == null) return;

    // opcional - información del archivo seleccionado
    debugPrint(
      "'${xFile.path}'"
          " '${xFile.name}'" // Captura de pantalla 2025-12-10 a las 14.29.44.png
          " '${xFile.mimeType}'" // image/png (solo en web)
          " ${await xFile.length()}" // 442728
          " '${await xFile.lastModified()}'", // 2025-12-10 14:29:44.736
    );

    // opcional - información de la imagen seleccionada
    final bytes = await xFile.readAsBytes();
    ui.Image image = await decodeImageFromList(bytes);
    debugPrint(
      "${image.width}x${image.height}", // 3024x4032
    );

    _imagePath = xFile.path;
    _imageName = xFile.name;
    _imageSize = await xFile.length();
    _imageWidth = image.width;
    _imageHeight = image.height;

    // mostrar la imagen
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Imagen (Galería)'),
      ),
      body: ListView(
        children: [
          if (_imagePath != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                children: [
                  Text('$_imageName ($_imageSize bytes)'),
                  Text('${_imageWidth}x$_imageHeight => ${((250*_imageWidth!)/_imageHeight!).toInt()}x250'),
                  kIsWeb
                  // en web
                      ? Image.network(
                    _imagePath!,
                    height: 250,
                  )
                  // en el resto
                      : Image.file(
                    File(_imagePath!),
                    height: 250,
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ElevatedButton(onPressed: _getImage, child: Text('Obtener imagen')),
          ),
        ],
      ),
    );
  }
}