import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/keo_routes.dart';
import '../l10n/app_localizations.dart';
import '../state/app_info.dart';
import '../state/keo_settings.dart';
import '../ui/keo_ui.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value;
    final notifier = ref.read(settingsProvider.notifier);
    return KeoPage(
      heading: t.settings,
      children: [
        KeoPanel(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(t.music),
                subtitle: Text(t.musicHint),
                value: settings?.music ?? true,
                onChanged: notifier.setMusic,
              ),
              SwitchListTile(
                title: Text(t.soundEffects),
                subtitle: Text(t.soundEffectsHint),
                value: settings?.sound ?? true,
                onChanged: notifier.setSound,
              ),
              SwitchListTile(
                title: Text(t.vibration),
                subtitle: Text(t.vibrationHint),
                value: settings?.vibration ?? true,
                onChanged: notifier.setVibration,
              ),
              ListTile(title: Text(t.language), trailing: Text(t.vietnamese)),
              ListTile(title: Text(t.controls), trailing: Text(t.joystick)),
              ListTile(
                title: Text(t.version),
                trailing: Text(ref.watch(appVersionProvider).value ?? '—'),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        KeoButton(
          title: t.done,
          icon: Icons.check,
          onPressed: () => keoPop(context),
        ),
      ],
    );
  }
}
