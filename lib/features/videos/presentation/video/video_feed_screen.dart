import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  Future fetchVideoFeed() async {
    await Provider.of<VideoFeedProvider>(context, listen: false)
        .fetchVideoFeed();
  }

  @override
  void initState() {
    fetchVideoFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoFeedProvider>(builder: (_, videoProvider, __) {
      return Scaffold(
          body: Column(
        children: [
          if (videoProvider.isLoading) CircularProgressIndicator(),
          if (videoProvider.hasError) Text(videoProvider.error!),
          if (!videoProvider.hasVideos) Text('No videos found'),
          if (videoProvider.hasVideos) ...[
            ListView.builder(
                itemCount: videoProvider.videoFeedList.length,
                itemBuilder: (context, index) {
                  final feed = videoProvider.videoFeedList[index];
                  return ListTile(
                    title: Text(feed.username),
                    subtitle: Text('More videos ${feed.childVideoCount}'),
                  );
                })
          ]
        ],
      ));
    });
  }
}
