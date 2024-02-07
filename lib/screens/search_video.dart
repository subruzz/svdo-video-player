import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:svdomain/provider/video-providers/serach_video_provider.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/widgets/helping-widgets/search-video-helper/items_search_screen.dart';
import 'package:svdomain/widgets/textfields.dart';

class SearchVideoScreen extends ConsumerStatefulWidget {
  const SearchVideoScreen({super.key, required this.index});
  final int index;
  @override
  ConsumerState<SearchVideoScreen> createState() => _SearchVideoScreenState();
}
class _SearchVideoScreenState extends ConsumerState<SearchVideoScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // _foundVideos = widget.videoDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final foundVideos = ref.watch(searchVideoProvider);
    return PopScope(
      onPopInvoked: (value) {
        ref.read(searchVideoProvider.notifier).onback();
      },
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Image.asset(
                      'assets/images/applogo.png',
                      width: 120,
                      color: AppColors.imageColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: TextfieldForSearch(
                      text: 'Search Videos..',
                      index: widget.index,
                      focusNode: _searchFocusNode,
                      ref: ref),
                ),
                const SizedBox(
                  height: 20,
                ),
                foundVideos.isEmpty
                    ?  Center(
                        child: Column(
                          children: [
                            Lottie.asset('assets/images/Animation - 1707131269098 (1).json'),
                           const  Text('No Videos Found'),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: foundVideos.length,
                          itemBuilder: (ctx, index) => SearchItems(
                            foundVideos: foundVideos,
                            video: foundVideos[index],
                            index: index,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
