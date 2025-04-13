import 'package:flutter/material.dart';
import 'package:room_me/events_calendar.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomMe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthScreen(),
      //home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 1; // Default to Calendar Page

  final List<Widget> _pages = const [
    TaskPage(),
    TableEventsExample(),
    ProfilePage(),
  ];

  final List<String> _titles = [
    'Tasks',
    'Calendar',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Task Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Profile Page'),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up / Sign In')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SupaEmailAuth(
            // For mobile apps, set a custom redirect URL if necessary.
            // If running on the web, you might use null to rely on the current location.
            redirectTo: Theme.of(context).platform == TargetPlatform.android ||
                         Theme.of(context).platform == TargetPlatform.iOS
                ? 'io.mydomain.myapp://callback'
                : null,
            // Callback after a successful sign in.
            onSignInComplete: (response) {
              // Navigate to your app's home page or perform any other necessary actions.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainNavigation()),
              );
              debugPrint('User signed in: ${response.user}');
            },
            // Callback after a successful sign up.
            onSignUpComplete: (response) {
              // Handle post-signup logic such as moving to a user onboarding screen.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainNavigation()),
              );
              debugPrint('User signed up: ${response.user}');
            },
            // Additional form fields, for example to capture a username.
            metadataFields: [
              MetaDataField(
                prefixIcon: const Icon(Icons.person),
                label: 'Username',
                key: 'username',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
