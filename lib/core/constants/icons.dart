import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';

class ConstantIcons {
  static const searchIcon = Icon(
    Icons.search,
    size: 30,
  );
  static Widget homeIcon({Color color = blackColor, double? size = 20}) => Icon(
    Icons.home,
    size: size,
    color: color,
  );

  static Widget addPostIconF({Color color = blackColor}) => Icon(
        Icons.add_circle_outline,
        size: 30,
        color: color,
      );
  static Widget visibilityOff({Color color = blackColor}) => Icon(
    Icons.visibility_off,
    size: 30,
    color: color,
  );
  static Widget visibility({Color color = blackColor}) => Icon(
    Icons.visibility,
    size: 30,
    color: color,
  );
  static const addPostIcon = Icon(
    Icons.add_circle_outline,
    size: 30,
  );
  static const defaultMemberIcon = Icon(
    Icons.person,
    size: 30,
  );
  static const loveIcon = Icon(
    Icons.favorite_border,
    size: 30,
  );
  static const addCommentIcon = Icon(
    Icons.insert_comment,
    size: 30,
  );
  static const sendMessageIcon = Icon(
    Icons.textsms,
    size: 30,
  );
  static const navigateNextIcon = Icon(
    Icons.navigate_next,
    size: 30,
  );
  static const photoIcon = Icon(
    Icons.photo_camera,
    size: 30,
  );
  static const sendcommentIcon = Icon(
    Icons.send,
    size: 30,
  );
  static const videoCallIcon = Icon(
    Icons.video_call,
    size: 30,
  );
  static const phoneIcon = Icon(
    Icons.phone,
    size: 30,
  );

  static Widget phoneIconF({Color color = blackColor, double size = 30}) =>
      Icon(
        Icons.phone,
        size: size,
        color: color,
      );

  static Widget chatIcon({Color color = blackColor, double size = 20}) =>
      Icon(
        Icons.chat,
        size: size,
        color: color,
      );

  static const emojiIcon = Icon(
    Icons.emoji_emotions,
    size: 30,
  );
  static const attachFileIcon = Icon(
    Icons.attach_file,
    size: 30,
  );
  static const microIcon = Icon(
    Icons.keyboard_voice,
    size: 30,
    color: blackColor,
  );
  static const sendIcon = Icon(
    Icons.send,
    size: 30,
    color: blackColor,
  );

  static Widget backIcon(BuildContext context, {Color color = blackColor, double size = 30}) => IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
        size: 20,
      ));

  static Widget editIcon({Color color = blackColor, double size = 30}) => Icon(
        Icons.edit,
        color: color,
        size: size,
      );

  static Widget notificationIcon({Color color = blackColor, double size = 20}) => Icon(
    Icons.notifications,
    color: color,
    size: size,
  );
  static Widget postIcon({Color color = blackColor, double size = 20}) => Icon(
    Icons.public_rounded,
    color: color,
    size: size,
  );
  static Widget profileIcon({Color color = blackColor, double size = 20}) => Icon(
    Icons.person,
    color: color,
    size: size,
  );

  static Widget jobIcon({Color color = blackColor, double size = 30}) =>
      Icon(Icons.work, color: color, size: size);

  static Widget workshopIcon({Color color = blackColor, double size = 30}) =>
      Icon(
        Icons.home_work_sharp,
        color: color,
        size: size,
      );

  static Widget emailIcon({Color color = blackColor, double size = 30}) => Icon(
        Icons.mail,
        color: color,
        size: size,
      );

  static Widget cameraIcon({Color color = blackColor, double size = 30}) =>
      Icon(
        Icons.camera_alt_rounded,
        color: color,
        size: size,
      );

  static Widget libraryIcon({Color color = blackColor, double size = 30}) =>
      Icon(
        Icons.photo_library_outlined,
        color: color,
        size: size,
      );

  static const _fontFamily = 'TikTokIcons';

  static const IconData chat_bubble = IconData(0xe808, fontFamily: _fontFamily);
  static const IconData create = const IconData(0xe809, fontFamily: _fontFamily);
  static const IconData heart = const IconData(0xe80a, fontFamily: _fontFamily);
  static const IconData home = const IconData(0xe80b, fontFamily: _fontFamily);
  static const IconData messages = const IconData(0xe80c, fontFamily: _fontFamily);
  static const IconData profile = const IconData(0xe80d, fontFamily: _fontFamily);
  static const IconData reply = const IconData(0xe80e, fontFamily: _fontFamily);
  static const IconData search = const IconData(0xe80f, fontFamily: _fontFamily);
}

