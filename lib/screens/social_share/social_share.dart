import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SocialShareScreen extends StatelessWidget {
  const SocialShareScreen({Key? key}) : super(key: key);

  Future<void> shareToFacebook(String postId) async {
    try {
      final dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: 'https://devinnoapp.page.link',
        link: Uri.parse('https://devinnoapp.page.link/post?postId=$postId'),
        androidParameters: const AndroidParameters(
          packageName: 'com.example.instax',
        ),
        iosParameters: const IOSParameters(
          bundleId: 'com.example.instax',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Example of a Dynamic Link',
          imageUrl: Uri.parse(
            'https://www.format.com/wp-content/uploads/portrait_of_black_man.jpg',
          ),
          description: 'This link works whether app is installed or not!',
        ),
      );

      final ShortDynamicLink dynamicUrl =
          await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
      );
      final shortLink = dynamicUrl.shortUrl;

      Share.shareUri(shortLink);

      // final facebookShareURL = Uri.encodeFull(shortLink.toString());
      // final url =
      //     "https://www.facebook.com/sharer/sharer.php?u=$facebookShareURL";

      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
    } catch (error) {
      print("Error sharing to Facebook: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share to Facebook'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            shareToFacebook('123');
          },
          child: const Text('Share to Facebook'),
        ),
      ),
    );
  }
}
