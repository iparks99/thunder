import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_highlight/smooth_highlight.dart';
import 'package:thunder/core/enums/local_settings.dart';
import 'package:thunder/settings/widgets/settings_list_tile.dart';
import 'package:thunder/user/bloc/user_settings_bloc.dart';
import 'package:thunder/utils/media/image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateBio extends StatefulWidget {
  final LocalSettings? settingToHighlight;

  const UpdateBio({super.key, this.settingToHighlight});

  @override
  State<UpdateBio> createState() => _UpdateBio();
}

class _UpdateBio extends State<UpdateBio> {
  GlobalKey settingToHighlightKey = GlobalKey();
  LocalSettings? settingToHighlight;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.settingToHighlight != null) {
        setState(() => settingToHighlight = widget.settingToHighlight);

        // Need some delay to finish building, even though we're in a post-frame callback.
        Timer(const Duration(milliseconds: 500), () {
          if (settingToHighlightKey.currentContext != null) {
            // Ensure that the selected setting is visible on the screen
            Scrollable.ensureVisible(
              settingToHighlightKey.currentContext!,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          }

          // Give time for the highlighting to appear, then turn it off
          Timer(const Duration(seconds: 1), () {
            setState(() => settingToHighlight = null);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final highlightAvatar = settingToHighlight == LocalSettings.accountAvatar ? settingToHighlightKey : null;
    final highlightBanner = settingToHighlight == LocalSettings.accountBanner ? settingToHighlightKey : null;
    final highlightBio = settingToHighlight == LocalSettings.accountBio ? settingToHighlightKey : null;

    Future<void> selectImage(BuildContext context, Function onSuccess) async {
      String imagePath = await selectImageToUpload();
      onSuccess(imagePath);
    }

    return Column(
      children: [
        SmoothHighlight(
          key: highlightAvatar,
          useInitialHighLight: highlightAvatar != null,
          enabled: highlightAvatar != null,
          color: theme.colorScheme.primaryContainer,
          child: SettingsListTile(
            icon: Icons.account_circle_outlined,
            description: l10n.changeAvatar,
            widget: const SizedBox(
              height: 42.0,
              child: Icon(Icons.chevron_right_rounded),
            ),
            onTap: () {
              selectImage(context, (image) {
                if (mounted) context.read<UserSettingsBloc>().add(UpdateUserSettingsEvent(avatar: image));
              });
            },
          ),
        ),
        SmoothHighlight(
          key: highlightBanner,
          useInitialHighLight: highlightBanner != null,
          enabled: highlightBanner != null,
          color: theme.colorScheme.primaryContainer,
          child: SettingsListTile(
            icon: Icons.image_outlined,
            description: l10n.changeBanner,
            widget: const SizedBox(
              height: 42.0,
              child: Icon(Icons.chevron_right_rounded),
            ),
            onTap: () async {
              String imagePath = await selectImageToUpload();
            },
          ),
        ),
        SmoothHighlight(
          key: highlightBio,
          useInitialHighLight: highlightBio != null,
          enabled: highlightBio != null,
          color: theme.colorScheme.primaryContainer,
          child: SettingsListTile(
            icon: Icons.edit_note,
            description: l10n.changeBio,
            widget: const SizedBox(
              height: 42.0,
              child: Icon(Icons.chevron_right_rounded),
            ),
            onTap: () async {
              String imagePath = await selectImageToUpload();
            },
          ),
        ),
      ],
    );
  }
}
