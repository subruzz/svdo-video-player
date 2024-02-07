import 'package:flutter/material.dart';
import 'package:svdomain/data/services/email_services.dart';
import 'package:svdomain/screens/about_app.dart';
import 'package:svdomain/screens/privacy_screen.dart';
import 'package:svdomain/screens/recently_watched.dart';
import 'package:svdomain/widgets/helping-widgets/more-screen/more_item.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoreItems(
          icon: Icons.access_time_rounded,
          title: 'Recently Played',
          onClick: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const RecentlyWatchedScreen(),
                ));
          },
        ),
       
        MoreItems(
          icon: Icons.headset_mic_rounded,
          title: 'Contact Us',
          onClick: () async {
            EmailService.openGmail();
          },
        ),
        
        MoreItems(
            icon: Icons.info,
            title: 'About',
            onClick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const AboutAppScreen()));
            }),
        
        MoreItems(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            onClick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const PrivacyScreen()));
            }),
        
        MoreItems(
          icon: Icons.share,
          title: 'Share',
          onClick: () {},
        )
      ],
    );
  }
}
