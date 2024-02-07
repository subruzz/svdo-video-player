import 'package:flutter/material.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/screens/inside_playlist.dart';

class LikedVideoSingle extends StatelessWidget {
  const LikedVideoSingle({super.key,required this.likedVideos});
  final List<LikedVideo> likedVideos;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const InsidePlaylist(
                name: 'Liked Videos',
                page: 'liked',
              ),
            ),
          );
        } catch (e) {
          print(e);
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/icons8-love-30.png',
                width: 58, fit: BoxFit.cover),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Liked Videos',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${likedVideos.length} Videos',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
