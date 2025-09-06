import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/home_page.dart';
import '../features/quiz/presentation/quiz_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => const CupertinoPage(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/quiz',
        name: 'quiz',
        pageBuilder: (context, state) => const CupertinoPage(
          child: QuizPage(),
        ),
      ),
    ],
  );
});
