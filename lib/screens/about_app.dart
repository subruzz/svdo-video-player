import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/applogo.png',
                width: 200,
                color: AppColors.imageColor,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Svdo is your ultimate offline video player, offering seamless playback without an internet connection. With a user-friendly interface, Svdo lets you effortlessly organize and enjoy your offline video library. Create personalized playlists for a curated experience, ensuring your favorite videos are just a tap away. Experience high-quality playback and customize your viewing with ease. Thank you for choosing Svdo - where offline entertainment meets simplicity.',
                softWrap: true,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.fontnButton),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Svdo',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '1.0.0',
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
