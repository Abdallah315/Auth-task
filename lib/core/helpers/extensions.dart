import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension UuidInt64Extension on String {
  int toInt64Hash() {
    final bytes = utf8.encode(this);
    final digest = sha256.convert(bytes);
    final byteData = ByteData.sublistView(
      Uint8List.fromList(digest.bytes.take(8).toList()),
    );
    return byteData.getInt64(0).abs();
  }
}
