import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

bool delete_button = false;

Widget buildAvatar(BuildContext context, String? avatarURL) {





  if (avatarURL == null) {
    return ClipOval(
      child: Image.network(
        "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small_2x/default-avatar-icon-of-social-media-user-vector.jpg",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    // );CircleAvatar(
    //   radius: 75, // half of the desired width and height of the default image
    //     backgroundImage: AssetImage('../assets/default_avatar.jpeg',
    //     ),

    ); // or any other default widget to show when the URL is null
  }
  else{


    return GestureDetector(
    onTap: () {
      if (avatarURL != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.transparent,
                  child: PhotoView(
                    imageProvider: NetworkImage(avatarURL),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                  ),
                ),
              ),
            );
          },
        );
      }
    },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // смещение тени
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            avatarURL,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      )
    );

    //
    // return ClipOval(
    //   child: Image.network(
    //     avatarURL,
    //     width: 150,
    //     height: 150,
    //     fit: BoxFit.cover,
    //   ),
    //);
  }


}
