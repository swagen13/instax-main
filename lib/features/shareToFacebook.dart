// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:job_post_repository/job_post_repository.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> shareToFacebook(BuildContext context, JobPost jobPost) async {
  try {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://devinnoapp.page.link',
      link: Uri.parse('https://devinnoapp.page.link/post?postId=1asdss'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.instax',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.instax',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Recruiting employees for ${jobPost.position} position!',
        imageUrl: Uri.parse(
          'https://www.format.com/wp-content/uploads/portrait_of_black_man.jpg',
        ),
        description:
            'We are looking for a ${jobPost.position} to join our team!',
      ),
    );

    final ShortDynamicLink dynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      // You can specify the behavior of the dynamic link here
      // For example, ShortDynamicLinkParameters(suffix: 'short_link')
    );
    final shortLink = dynamicUrl.shortUrl;
    print("shortLink: $shortLink");

    final facebookShareURL = Uri.encodeFull(shortLink.toString());

    print("facebookShareURL: $facebookShareURL");

    final url =
        "https://www.facebook.com/sharer/sharer.php?u=$facebookShareURL";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (error) {
    print("Error sharing to Facebook: $error");
  }
}
