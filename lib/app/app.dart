import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_chat/features/auth/repository/auth_repository.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/profile/screens/profile_screen.dart';

// Optional: Import other feature screens if needed
// import '../features/admin/screens/user_management_screen.dart';
// import '../features/common/screens/settings_screen.dart';
// import '../features/common/screens/terms_screen.dart';
// import '../features/common/screens/about_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(AuthRepository())..add(AppStarted()),
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      initialLocation: '/login',
      refreshListenable: GoRouterRefreshStream(
        BlocProvider.of<AuthBloc>(context).stream,
      ),

      debugLogDiagnostics:
          true, // Optional: helps during development to log routing decisions

      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),

        // Additional routes can go here, uncomment when implemented:
        /*
        GoRoute(
          path: '/user_management',
          builder: (context, state) => const UserManagementScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/terms',
          builder: (context, state) => const TermsScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutScreen(),
        ),
        */
      ],

      redirect: (context, state) {
        final authState = BlocProvider.of<AuthBloc>(context).state;
        final loggedIn = authState is Authenticated;
        final loggingIn =
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register';

        // If not logged in, redirect all routes except login/register to login.
        if (!loggedIn && !loggingIn) {
          return '/login';
        }

        // If logged in, prevent going back to login/register
        if (loggedIn && loggingIn) {
          return '/chat';
        }

        // No redirect needed
        return null;
      },

      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(child: Text('No page found for ${state.location}')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Me Chat',
      theme: ThemeData(primarySwatch: Colors.teal),

      routerConfig: _router,
    );
  }
}

/// Helper class to convert a Stream into a ChangeNotifier for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
