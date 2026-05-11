import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hec_app/app.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: const App()
  ));
}
