import 'package:flutter/material.dart';
import 'package:svdomain/data/services/email_services.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/widgets/helping-widgets/privacy-screen/privacy_items.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                const PrivacyItems(
                    heading: 'Privacy Statement',
                    content:
                        'We prioritize the privacy of our users. This Privacy Policy outlines the types of information we collect and how we use it. By using the Svdo app, you consent to the terms outlined in this policy.'),
                const SizedBox(
                  height: 15,
                ),
                const PrivacyItems(
                    heading: 'Information Collection',
                    content:
                        'Svdo does not collect any personal information from users. The app only accesses video files stored on the user\'s device for the purpose of playback within the app. We do not store or transmit any user data to external servers.'),
                const SizedBox(
                  height: 15,
                ),
                const PrivacyItems(
                    heading: 'Data Security',
                    content:
                        'We take reasonable measures to protect the security of your data within the Svdo app. However, please be aware that no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security.'),
                const SizedBox(
                  height: 15,
                ),
                const PrivacyItems(
                    heading: 'Third-party Services',
                    content:
                        'Svdo does not integrate with any third-party services or APIs that collect user data. We do not display advertisements or utilize analytics services within the app.'),
                const SizedBox(
                  height: 15,
                ),
                const PrivacyItems(
                    content:
                        'We may update our Privacy Policy from time to time. Any changes will be posted within the app, and your continued use of Svdo after any modifications indicates your acceptance of the updated terms.',
                    heading: 'Changes to This Privacy Policy'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'If you have any questions or concerns about our Privacy Policy, please contact us ',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TextButton(
                    onPressed: () {
                        EmailService.openGmail();
                    },
                    child: Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.secondaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                    )),
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
      ),
    );
  }
}
