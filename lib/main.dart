import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/data/models/playlists_data.dart';
import 'package:svdomain/data/models/recently_watched.dart';
import 'package:svdomain/provider/theme-providers/settings_provider.dart';
import 'package:svdomain/screens/splash_screen.dart';
import 'package:svdomain/util-classes/styling/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayListModelsAdapter());
  Hive.registerAdapter(LikedVideosAdadpter());
  Hive.registerAdapter(RecentvideoAdapter());
  await Hive.openBox('userPlaylist');
  await Hive.openBox('likedVideos');
  await Hive.openBox('recents');
  await Hive.openBox('video_duration');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settings[Filter.darkMode] ?? true ? darkTheme : lightTheme,
      home: const SplashScreen(),
    );
  }
}
