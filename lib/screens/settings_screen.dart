import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/theme-providers/settings_provider.dart';
import 'package:svdomain/widgets/helping-widgets/settings_helper.dart/settings_items.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  void changeSettings(bool value, WidgetRef ref, Filter filter) {
    ref.read(settingsProvider.notifier).changeSettings(value, filter);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SettingsItem(
            title: 'Dark Mode',
            isEnabled: isEnabled[Filter.darkMode] ?? true,
            onEnable: (value) {
              changeSettings(value, ref, Filter.darkMode);
            },
          ),
          // SettingsItem(title: 'AutoPlay'),
          // SettingsItem(title: 'Double-Tap To Seek'),
          SettingsItem(
            title: 'Show Recently Watched',
            isEnabled: isEnabled[Filter.showRecents] ?? true,
            onEnable: (value) {
              changeSettings(value, ref, Filter.showRecents);
            },
          ),
        ],
      ),
    );
  }
}
