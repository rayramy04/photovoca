import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material Study Coach',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      routerConfig: router,
    );
  }
}
