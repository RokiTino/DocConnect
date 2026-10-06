import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'care/care_app.dart';

const careUrl = String.fromEnvironment('CARE_SUPABASE_URL');
const careKey = String.fromEnvironment('CARE_SUPABASE_KEY');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (careUrl.isNotEmpty && careKey.isNotEmpty) {
    await Supabase.initialize(url: careUrl, anonKey: careKey);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DocConnect',
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff176653)),
            scaffoldBackgroundColor: const Color(0xfff3f6f4),
            useMaterial3: true),
        home: careUrl.isNotEmpty && careKey.isNotEmpty
            ? const CareApp()
            : const Scaffold(
                body: Center(
                    child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                            'DocConnect\nThe clinic connection has not been configured.',
                            textAlign: TextAlign.center)))),
      );
}
