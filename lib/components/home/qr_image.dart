import 'package:qr_flutter/qr_flutter.dart';

QrImage qrImage(String text) {
    return QrImage(
      data: text,
      version: QrVersions.auto,
      size: 94.488188976,
    );
  }