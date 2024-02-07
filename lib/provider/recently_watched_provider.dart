import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/hive/recent.dart';
import 'package:svdomain/data/models/recently_watched.dart';

class RecentlyWatchedProvider extends StateNotifier<List<RecentVideos>> {
  RecentlyWatchedProvider() : super(RecentDb.getRecents());
  void _updateState() {
    state = RecentDb.getRecents();
  }

  bool addToRecent(RecentVideos recent) {
    final isAlready = RecentDb.addToRecent(recent);
    _updateState();
    return isAlready;
  }

  void deleteFromRecents(var key) async {
    RecentDb.deleteFromRecents(key);
    _updateState();
  }

  void clearRecent() async {
    RecentDb.clearRecnet().then((value) => _updateState());
  }
}

final recentlyWatchedProvider =
    StateNotifierProvider<RecentlyWatchedProvider, List<RecentVideos>>(
        (ref) => RecentlyWatchedProvider());
