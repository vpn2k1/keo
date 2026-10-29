// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'KEO - Vượt Phòng Tuyến';

  @override
  String get gameName => 'KEO';

  @override
  String get gameSubtitle => 'VƯỢT PHÒNG TUYẾN';

  @override
  String get playNow => 'Chơi ngay';

  @override
  String get levelSelect => 'Chọn màn';

  @override
  String get howToPlay => 'Cách chơi';

  @override
  String get settings => 'Cài đặt';

  @override
  String get character => 'Nhân vật';

  @override
  String get characterSelect => 'Chọn nhân vật';

  @override
  String get back => 'Quay lại';

  @override
  String get done => 'Xong';

  @override
  String get start => 'Bắt đầu';

  @override
  String unlockedCount(int unlocked, int total) {
    return 'Đã mở khóa: $unlocked/$total';
  }

  @override
  String levelLabel(int level) {
    return 'Màn $level';
  }

  @override
  String secondsShort(String value) {
    return '${value}s';
  }

  @override
  String get tutorialStep1 => 'Kéo joystick ở góc trái để chạy theo mọi hướng.';

  @override
  String get tutorialStep2 =>
      'Người canh chỉ chạy trái/phải trên vạch ngang của mình.';

  @override
  String get tutorialStep3 =>
      'Tới gần vạch là người canh bám theo để chặn đường bạn.';

  @override
  String get tutorialStep4 =>
      'Vượt qua vạch đích đỏ rồi quay về xuất phát mới thắng.';

  @override
  String get music => 'Âm nhạc';

  @override
  String get musicHint => 'Nhạc nền khi đang chơi';

  @override
  String get soundEffects => 'Hiệu ứng âm thanh';

  @override
  String get soundEffectsHint => 'Tiếng khi thắng hoặc bị bắt';

  @override
  String get vibration => 'Rung';

  @override
  String get vibrationHint => 'Rung khi thắng hoặc bị bắt';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get controls => 'Điều khiển';

  @override
  String get joystick => 'Joystick';

  @override
  String get version => 'Phiên bản';

  @override
  String goalGo(int crossed, int total) {
    return 'ĐI TỚI ĐÍCH · $crossed/$total vạch';
  }

  @override
  String get goalReturn => 'QUAY VỀ XUẤT PHÁT!';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get winTitle => 'Chiến thắng!';

  @override
  String get loseTitle => 'Bị bắt rồi!';

  @override
  String finishedAll(int total) {
    return 'Phá đảo $total màn!';
  }

  @override
  String elapsedTime(String value) {
    return 'Thời gian: ${value}s';
  }

  @override
  String get newBest => 'Kỷ lục mới!';

  @override
  String bestTime(String value) {
    return 'Kỷ lục: ${value}s';
  }

  @override
  String get resume => 'Tiếp tục';

  @override
  String get nextLevel => 'Màn tiếp';

  @override
  String get replay => 'Chơi lại';

  @override
  String get goHome => 'Về trang chủ';
}
