import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static Future<void> openGmail() async {
const url = 'mailto:subruzz86@gmail.com?subject=Regarding%20Your%20App/Website&body=';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
