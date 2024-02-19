part of 'liked_video.dart';

class LikedVideosAdadpter extends TypeAdapter<LikedVideo> {
  @override
  final int typeId = 2;
  @override
  LikedVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedVideo(
      videoFile: fields[0] as String,
      favoriteTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LikedVideo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.videoFile)
      ..writeByte(1)
      ..write(obj.favoriteTime);
  }
}
