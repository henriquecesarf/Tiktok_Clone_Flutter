import 'package:flutter/material.dart';
import 'videos.dart'; // Certifique-se de que você importou o arquivo correto

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  int _selectedIndex = 0; // Índice do item selecionado

  // Lista de vídeos (URL dos vídeos)
  final List<String> videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Atualiza o índice quando o usuário toca em um item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TikTok Clone'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Pesquisar");
            },
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length, // Usa a lista de vídeos
        itemBuilder: (context, index) {
          return VideoScreen(
            videoUrl: videos[index], // Passa a URL do vídeo específico
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Item atual
        backgroundColor: Colors.black,
        onTap: _onItemTapped, // Atualiza a tela quando o item for tocado
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 20,
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 20,
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
