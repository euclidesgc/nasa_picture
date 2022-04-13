import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../domain/entities/media_entity.dart';

class DetailPage extends StatefulWidget {
  final MediaEntity media;
  const DetailPage({Key? key, required this.media}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.media.url);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        loop: true,
        hideControls: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture detail'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.media.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Date: ${widget.media.date}", style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            widget.media.mediaType == 'image'
                ? InteractiveViewer(
                    child: CachedNetworkImage(
                      imageUrl: widget.media.url,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )
                // Image.network(widget.media.url)
                : YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {},
                  ),
            const SizedBox(height: 16),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: 8.0,
                child: SingleChildScrollView(
                  child: Text(
                    widget.media.explanation,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
