// import 'package:flutter/material.dart';
//
// import '../../single_chat/single_chat_screen.dart';
//
// class ChatMenuCard extends StatefulWidget {
//   String text;
//   String secondaryText;
//   String image;
//   String time;
//   bool isMessageRead;
//
//   ChatMenuCard(
//       {super.key, required this.text,
//       required this.secondaryText,
//       required this.image,
//       required this.time,
//       required this.isMessageRead});
//
//   @override
//   _ChatMenuCardState createState() => _ChatMenuCardState();
// }
//
// class _ChatMenuCardState extends State<ChatMenuCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return SingleChatScreen();
//         }));
//       },
//       child: Container(
//         padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   const CircleAvatar(
//                     backgroundImage: NetworkImage("https://images.unsplash.com/photo-1525253086316-d0c936c814f8"),
//                     maxRadius: 30,
//                   ),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   Expanded(
//                     child: Container(
//                       color: Colors.transparent,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(widget.text),
//                           const SizedBox(
//                             height: 6,
//                           ),
//                           Text(
//                             widget.secondaryText,
//                             style: TextStyle(
//                                 fontSize: 14, color: Colors.grey.shade500),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               widget.time,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: widget.isMessageRead
//                       ? Colors.pink
//                       : Colors.grey.shade500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
