import 'package:flutter/material.dart';
import 'package:lemmy_api_client/v3.dart';
import 'package:thunder/shared/avatars/user_avatar.dart';
import 'package:thunder/utils/media/image.dart';

class EditableUserAvatar extends StatelessWidget {
  final Person person;
  final double radius;
  const EditableUserAvatar({super.key, required this.person, this.radius = 16.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String imagePath = await selectImageToUpload();
      },
      child: UserAvatar(
        person: person,
        radius: radius,
      ),
    );
  }
}
