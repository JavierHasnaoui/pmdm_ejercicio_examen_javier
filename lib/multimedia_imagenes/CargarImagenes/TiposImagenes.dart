
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagesImagePage extends StatefulWidget {
  const ImagesImagePage({super.key});

  @override
  State<ImagesImagePage> createState() => _ImagesImagePageState();
}

class _ImagesImagePageState extends State<ImagesImagePage> {
  late Future<Uint8List> _resGetBytesFromAsset;

  Future<Uint8List> _getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    _resGetBytesFromAsset = _getBytesFromAsset('assets/imagenes/cisne.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Imágenes (Image)'),
      ),
      body: ListView(
        children: [
          _buildImageFromAsset(),
          _buildImageFromInternet(),
          _buildImageGif(),
          _buildImageFromMemory(),
          _buildFadeInImage(),
        ],
      ),
    );
  }

  Widget _buildImageFromAsset() {
    return Column(
      children: [
        Text('Asset'),
        Container(
          color: Colors.black,
          child: Image.asset(
            'assets/imagenes/cisne.jpg',
            width: 300,
            height: 100,
            fit: .cover,
            color: Colors.green,
            colorBlendMode: .darken,
            semanticLabel: 'CISNE',
          ),
        ),
      ],
    );
  }

  final _id = 64; // Random().nextInt(1084) + 1;
  final _sizeOri = 3500;
  final _sizeDest = 200;

  Widget _buildImageFromInternet() {
    return Column(
      children: [
        SizedBox(height: 8),
        Text('Internet (id: $_id, ${_sizeOri}x$_sizeOri => ${_sizeDest}x$_sizeDest )'),
        SizedBox(
          height: _sizeDest.toDouble(),
          child: Image.network(
            'https://picsum.photos/id/$_id/3500',
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Align(
                alignment: .topCenter,
                child: LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? (loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!)
                      : null,
                ),
              );
            },
            height: _sizeDest.toDouble(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGif() {
    return Column(
      children: [
        SizedBox(height: 8),
        Text('Internet (GIF)'),
        Image.network(
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
          height: 100,
        ),
      ],
    );
  }

  Widget _buildImageFromMemory() {
    return Column(
      children: [
        SizedBox(height: 8),
        Text('Memory'),
        FutureBuilder(
          future: _resGetBytesFromAsset,
          builder: (context, snapshot) {
            if (snapshot.connectionState == .done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString(), style: TextStyle(color: Colors.red));
              } else {
                return Image.memory(
                  snapshot.data!,
                  height: 100,
                  width: double.infinity,
                  fit: .fitWidth,
                );
              }
            } else {
              return const Center(child: LinearProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Widget _buildFadeInImage() {
    return Column(
      children: [
        SizedBox(height: 8),
        Text('Internet (FadeIn)'),
        FadeInImage.assetNetwork(
          placeholder: 'assets/images/espere.webp',
          image: 'https://picsum.photos/id/${_id+1}/3500',
          height: 100,
        ),
      ],
    );
  }
}
