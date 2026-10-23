import 'package:flutter/material.dart';

import 'package:namma_kaimagga_app/core/services/pref_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefService.init();

  runApp(const NammaKaimaggaApp());
}
