import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('vi')];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'KEO - Vượt Phòng Tuyến'**
  String get appTitle;

  /// No description provided for @gameName.
  ///
  /// In vi, this message translates to:
  /// **'KEO'**
  String get gameName;

  /// No description provided for @gameSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'VƯỢT PHÒNG TUYẾN'**
  String get gameSubtitle;

  /// No description provided for @playNow.
  ///
  /// In vi, this message translates to:
  /// **'Chơi ngay'**
  String get playNow;

  /// No description provided for @levelSelect.
  ///
  /// In vi, this message translates to:
  /// **'Chọn màn'**
  String get levelSelect;

  /// No description provided for @howToPlay.
  ///
  /// In vi, this message translates to:
  /// **'Cách chơi'**
  String get howToPlay;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @character.
  ///
  /// In vi, this message translates to:
  /// **'Nhân vật'**
  String get character;

  /// No description provided for @characterSelect.
  ///
  /// In vi, this message translates to:
  /// **'Chọn nhân vật'**
  String get characterSelect;

  /// No description provided for @back.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get back;

  /// No description provided for @done.
  ///
  /// In vi, this message translates to:
  /// **'Xong'**
  String get done;

  /// No description provided for @start.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get start;

  /// No description provided for @unlockedCount.
  ///
  /// In vi, this message translates to:
  /// **'Đã mở khóa: {unlocked}/{total}'**
  String unlockedCount(int unlocked, int total);

  /// No description provided for @levelLabel.
  ///
  /// In vi, this message translates to:
  /// **'Màn {level}'**
  String levelLabel(int level);

  /// No description provided for @secondsShort.
  ///
  /// In vi, this message translates to:
  /// **'{value}s'**
  String secondsShort(String value);

  /// No description provided for @tutorialStep1.
  ///
  /// In vi, this message translates to:
  /// **'Kéo joystick ở góc trái để chạy theo mọi hướng.'**
  String get tutorialStep1;

  /// No description provided for @tutorialStep2.
  ///
  /// In vi, this message translates to:
  /// **'Người canh chỉ chạy trái/phải trên vạch ngang của mình.'**
  String get tutorialStep2;

  /// No description provided for @tutorialStep3.
  ///
  /// In vi, this message translates to:
  /// **'Tới gần vạch là người canh bám theo để chặn đường bạn.'**
  String get tutorialStep3;

  /// No description provided for @tutorialStep4.
  ///
  /// In vi, this message translates to:
  /// **'Vượt qua vạch đích đỏ rồi quay về xuất phát mới thắng.'**
  String get tutorialStep4;

  /// No description provided for @music.
  ///
  /// In vi, this message translates to:
  /// **'Âm nhạc'**
  String get music;

  /// No description provided for @musicHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhạc nền khi đang chơi'**
  String get musicHint;

  /// No description provided for @soundEffects.
  ///
  /// In vi, this message translates to:
  /// **'Hiệu ứng âm thanh'**
  String get soundEffects;

  /// No description provided for @soundEffectsHint.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng khi thắng hoặc bị bắt'**
  String get soundEffectsHint;

  /// No description provided for @vibration.
  ///
  /// In vi, this message translates to:
  /// **'Rung'**
  String get vibration;

  /// No description provided for @vibrationHint.
  ///
  /// In vi, this message translates to:
  /// **'Rung khi thắng hoặc bị bắt'**
  String get vibrationHint;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @vietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @controls.
  ///
  /// In vi, this message translates to:
  /// **'Điều khiển'**
  String get controls;

  /// No description provided for @joystick.
  ///
  /// In vi, this message translates to:
  /// **'Joystick'**
  String get joystick;

  /// No description provided for @version.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản'**
  String get version;

  /// No description provided for @goalGo.
  ///
  /// In vi, this message translates to:
  /// **'ĐI TỚI ĐÍCH · {crossed}/{total} vạch'**
  String goalGo(int crossed, int total);

  /// No description provided for @goalReturn.
  ///
  /// In vi, this message translates to:
  /// **'QUAY VỀ XUẤT PHÁT!'**
  String get goalReturn;

  /// No description provided for @pause.
  ///
  /// In vi, this message translates to:
  /// **'Tạm dừng'**
  String get pause;

  /// No description provided for @winTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chiến thắng!'**
  String get winTitle;

  /// No description provided for @loseTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bị bắt rồi!'**
  String get loseTitle;

  /// No description provided for @finishedAll.
  ///
  /// In vi, this message translates to:
  /// **'Phá đảo {total} màn!'**
  String finishedAll(int total);

  /// No description provided for @elapsedTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian: {value}s'**
  String elapsedTime(String value);

  /// No description provided for @newBest.
  ///
  /// In vi, this message translates to:
  /// **'Kỷ lục mới!'**
  String get newBest;

  /// No description provided for @bestTime.
  ///
  /// In vi, this message translates to:
  /// **'Kỷ lục: {value}s'**
  String bestTime(String value);

  /// No description provided for @resume.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get resume;

  /// No description provided for @nextLevel.
  ///
  /// In vi, this message translates to:
  /// **'Màn tiếp'**
  String get nextLevel;

  /// No description provided for @replay.
  ///
  /// In vi, this message translates to:
  /// **'Chơi lại'**
  String get replay;

  /// No description provided for @goHome.
  ///
  /// In vi, this message translates to:
  /// **'Về trang chủ'**
  String get goHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
