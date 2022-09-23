import 'package:agropal/models/feed_item.dart';
import 'package:agropal/views/auth/login.dart';
import 'package:agropal/views/auth/otp.dart';
import 'package:agropal/views/auth/user_details.dart';
import 'package:agropal/views/home/detail_view.dart';
import 'package:agropal/views/home/home.dart';
import 'package:agropal/views/message/chat_view.dart';
import 'package:agropal/views/onBoard/locale_selection.dart';
import 'package:agropal/views/onBoard/splash.dart';
import 'package:agropal/views/post/create_post.dart';
import 'package:agropal/views/post/image_pick.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/chat':
        return MaterialPageRoute(
            builder: (context) => ChatView(
                  userId: settings.arguments as String,
                ));
      case '/detailView':
        return MaterialPageRoute(
            builder: (context) => DetailView(
                  feedItem: settings.arguments as FeedItem,
                ));
      case '/imagePick':
        return MaterialPageRoute(builder: (context) => const ImagePickView());
      case '/createPost':
        return MaterialPageRoute(builder: (context) => CreatePost());
      case '/home':
        return MaterialPageRoute(builder: (context) => const Home());
      case '/userDetails':
        return MaterialPageRoute(builder: (context) => UserDetails());
      case '/localeSelection':
        return MaterialPageRoute(builder: (context) => const LocaleSelection());
      case '/login':
        return MaterialPageRoute(builder: (context) => const Login());
      case '/otp':
        return MaterialPageRoute(builder: (context) => const OtpVerifier());
      case '/':
      default:
        return MaterialPageRoute(builder: (context) => const Splash());
    }
  }
}
