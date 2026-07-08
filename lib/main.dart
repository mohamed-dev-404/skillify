import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:skillify/app/app.dart';
import 'package:skillify/app/app_initializer.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize app services
  await AppInitializer.init();

  runApp(
    DevicePreview(
      enabled: false, //kDebugMode,
      builder: (context) => const Skillify(),
    ),
  );
}
