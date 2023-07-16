import 'package:flutter/material.dart';

import '../../../core/constants/icons.dart';

class RightPanel extends StatelessWidget {
  final String likes;
  final String comments;
  final String shares;
  final String profileImg;
  final String albumImg;
  const RightPanel({
    Key? key,
    required this.size,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.profileImg,
    required this.albumImg,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.3,
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getProfile(profileImg),
                    // getIcons(ConstantIcons.heart, likes, 35.0),
                    // getIcons(ConstantIcons.chat_bubble, comments, 35.0),
                    // getIcons(ConstantIcons.reply, shares, 25.0),
                    // getAlbum(albumImg)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Widget getAlbum(albumImg) {
  return Container(
    width: 50,
    height: 50,
    decoration: const BoxDecoration(
      // shape: BoxShape.circle,
      // color: black
    ),
    child: Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        ),
        Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        albumImg),
                    fit: BoxFit.cover)),
          ),
        )
      ],
    ),
  );
}

Widget getProfile(img) {
  return Container(
    width: 50,
    height: 60,
    child: Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      img),
                  fit: BoxFit.cover)),
        ),
        Positioned(
            bottom: 3,
            left: 18,
            child: Container(
              width: 20,
              height: 20,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFC2D55)),
              child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  )),
            ))
      ],
    ),
  );
}

Widget getIcons(icon, count, size) {
  return Container(
    child: Column(
      children: <Widget>[
        Icon(icon, color: Colors.white, size: size),
        const SizedBox(
          height: 5,
        ),
        Text(
          count,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}