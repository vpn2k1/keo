import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/keo_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool vibration = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => vibration = p.getBool('vibration') ?? true);
  }

  // Lưu ngay mỗi lần gạt để thoát bằng nút back không mất thay đổi.
  Future<void> _setVibration(bool v) async {
    setState(() => vibration = v);
    final p = await SharedPreferences.getInstance();
    await p.setBool('vibration', v);
  }

  @override
  Widget build(BuildContext context) => KeoPage(
        heading: 'Cài đặt',
        children: [
          KeoPanel(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                // shortcut: chưa có file âm thanh nên hai công tắc này tắt cứng; bật khi thêm asset audio.
                const SwitchListTile(
                  title: Text('Âm nhạc'),
                  subtitle: Text('Sắp có'),
                  value: false,
                  onChanged: null,
                ),
                const SwitchListTile(
                  title: Text('Hiệu ứng âm thanh'),
                  subtitle: Text('Sắp có'),
                  value: false,
                  onChanged: null,
                ),
                SwitchListTile(
                  title: const Text('Rung'),
                  subtitle: const Text('Rung khi thắng hoặc bị bắt'),
                  value: vibration,
                  onChanged: _setVibration,
                ),
                const ListTile(
                  title: Text('Ngôn ngữ'),
                  trailing: Text('Tiếng Việt'),
                ),
                const ListTile(
                  title: Text('Điều khiển'),
                  trailing: Text('Joystick'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          KeoButton(
            title: 'Xong',
            icon: Icons.check,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
}
