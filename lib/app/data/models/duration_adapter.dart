import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 1;

  @override
  Duration read(BinaryReader reader) {
    return Duration(microseconds: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMicroseconds);
  }
}