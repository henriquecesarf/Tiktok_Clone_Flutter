import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  const VideoScreen({super.key, required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  int likes = 0;
  int comments = 0;
  bool isLiked = false;
  bool isSave = false;
  int share = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // Atualiza a UI quando o vídeo estiver pronto
      })
      ..setLooping(true) // Deixa o vídeo em loop
      ..play(); // Inicia automaticamente
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera memória ao fechar
    super.dispose();
  }

  // Função para curtir o vídeo
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likes = isLiked ? likes + 1 : likes - 1;
    });
  }

  void toggleSave() {
    setState(() {
      isSave = !isSave;
    });
  }

  // Função para abrir os comentários (simples por enquanto)
  void openComments() {
    setState(() {
      comments++; // Apenas simulando que um novo comentário foi adicionado
    });
  }

  void shareCounter() {
    setState(() {
      share++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 📌 Vídeo em tela cheia
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),

          // 📌 Botões de interação (Curtidas e Comentários)
          Positioned(
            right: 0,
            bottom: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ❤️ Botão de Curtir
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 35,
                  ),
                  onPressed: toggleLike,
                ),
                Text(
                  likes.toString(),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),

                // 💬 Botão de Comentários
                IconButton(
                  icon: const Icon(Icons.question_answer,
                      color: Colors.white, size: 35),
                  onPressed: openComments,
                ),
                Text(
                  comments.toString(),
                  style: const TextStyle(color: Colors.white),
                ),

                IconButton(
                  icon: Icon(
                      isSave ? Icons.bookmark : Icons.bookmark_border_outlined,
                      color: Colors.white,
                      size: 35),
                  onPressed: toggleSave,
                ),

                // 💬 Botão de share
                IconButton(
                  icon: const Icon(Icons.reply, color: Colors.white, size: 35),
                  onPressed: shareCounter,
                ),
                Text(
                  share.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
