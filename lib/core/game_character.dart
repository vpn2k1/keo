/// Nhân vật người chơi chọn; [id] cũng là tiền tố tên file sprite.
class GameCharacter {
  const GameCharacter(this.id, this.name);

  final String id;
  final String name;

  static const selectedKey = 'selected_character';
  static const keo = GameCharacter('keo', 'Kéo');
  static const mai = GameCharacter('mai', 'Mai');
  static const nam = GameCharacter('nam', 'Nam');
  static const all = [keo, mai, nam];

  static GameCharacter fromId(String? id) {
    for (final character in all) {
      if (character.id == id) return character;
    }
    return keo;
  }

  String idleImage({bool back = false}) => '$id${_backTag(back)}_idle.png';

  String runImage(int frame, {bool back = false}) =>
      '$id${_backTag(back)}_run${_frameTag(frame)}.png';

  static String _backTag(bool back) {
    if (back) return '_back';
    return '';
  }

  static String _frameTag(int frame) {
    if (frame == 0) return '';
    return '_step';
  }
}
