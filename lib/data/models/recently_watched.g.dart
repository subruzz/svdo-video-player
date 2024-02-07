part of 'recently_watched.dart';

class RecentvideoAdapter extends TypeAdapter<RecentVideos> {
  @override
  final int typeId = 3;
  @override
  RecentVideos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentVideos(
      watchedLength: fields[2] as double,
      totalLength: fields[3] as double,
      videoFile: fields[0] as String,
      recentTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentVideos obj) {
    writer
      ..writeByte(4) // Write the number of fields (including the new ones)
      ..writeByte(0) // Field index 0
      ..write(obj.videoFile) // Write the videoFile field
      ..writeByte(1) // Field index 1
      ..write(obj.recentTime) // Write the recentTime field
      ..writeByte(2) // Field index 2
      ..write(obj.watchedLength) // Write the watchedLength field
      ..writeByte(3) // Field index 3
      ..write(obj.totalLength); // Write the totalLength field
  }
}
