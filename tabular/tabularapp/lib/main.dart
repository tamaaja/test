import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabularapp/pages/about_us.dart';
import 'package:tabularapp/pages/settings_page.dart';
import 'package:tabularapp/pages/signin.dart';
import '../controller/user_controller.dart';
import '../controller/workout_controller.dart';
import '../controller/train_controller.dart';
import 'controller/gemini_controller.dart';
import 'pages/home_page.dart';
import 'pages/workout_planner_page.dart';
import 'pages/train_page.dart';
import 'pages/activity_log_page.dart';
import 'pages/gemini_predict.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GymApp());
}

class GymApp extends StatefulWidget {
  @override
  _GymAppState createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Added TrainController
      providers: [
        ChangeNotifierProvider<TrainController>(create: (_) => TrainController()), 
        ChangeNotifierProvider<WorkoutController>(create: (_) => WorkoutController()), 
        ChangeNotifierProvider(create: (_) => UserController()), // UserController
        ChangeNotifierProvider<GeminiController>(create: (_) => GeminiController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym App',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          scaffoldBackgroundColor: _isDarkMode ? Colors.black : Colors.white,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
          ),
        ),
        home: MainPage(isDarkMode: _isDarkMode, toggleDarkMode: _toggleDarkMode), // Updated MainPage
        // home: SignInPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  MainPage({required this.isDarkMode, required this.toggleDarkMode});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail') ?? '';
    setState(() {
      _userEmail = email;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scaffoldKey.currentState?.openEndDrawer();
      });
    }
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
      (route) => false,
    );
  }

  final List<Widget> _pages = [
    HomePage(),
    WorkoutPlannerPage(),
    TrainPage(),
    ActivityLogPage(),
    Container(),
  ];

  void _editProfile(BuildContext context, UserController userController) {
    showDialog(
      context: context,
      builder: (context) {
        String name = userController.userName;
        int age = userController.umur;
        double weight = userController.berat;
        String gender = userController.gender;
        double height = userController.tinggiBadan;

        final _formKey = GlobalKey<FormState>(); // Key untuk form validasi

        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    initialValue: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      if (RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Name cannot contain numbers';
                      }
                      return null;
                    },
                    onChanged: (value) => name = value,
                  ),
                  // Age Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    initialValue: age.toString(),
                    validator: (value) {
                      int? parsedAge = int.tryParse(value ?? '');
                      if (parsedAge == null) {
                        return 'Age must be a number';
                      }
                      if (parsedAge < 15 || parsedAge > 120) {
                        return 'Age must be between 15 and 120';
                      }
                      return null;
                    },
                    onChanged: (value) => age = int.tryParse(value) ?? age,
                  ),
                  // Weight Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    initialValue: weight.toString(),
                    validator: (value) {
                      double? parsedWeight = double.tryParse(value ?? '');
                      if (parsedWeight == null) {
                        return 'Weight must be a number';
                      }
                      if (parsedWeight < 5 || parsedWeight > 500) {
                        return 'Weight must be between 5kg and 500kg';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        weight = double.tryParse(value) ?? weight,
                  ),
                  // Gender Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Gender'),
                    initialValue: gender,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      if (value != 'Male' && value != 'Female') {
                        return 'Gender must be Male or Female';
                      }
                      return null;
                    },
                    onChanged: (value) => gender = value,
                  ),
                  // Height Field
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    initialValue: height.toString(),
                    validator: (value) {
                      double? parsedHeight = double.tryParse(value ?? '');
                      if (parsedHeight == null) {
                        return 'Height must be a number';
                      }
                      if (parsedHeight < 50 || parsedHeight > 252) {
                        return 'Height must be between 50cm and 252cm';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        height = double.tryParse(value) ?? height,
                  ),
                ],
              ),
              ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validasi form sebelum menyimpan
                if (_formKey.currentState!.validate()) {
                  userController.updateUserProfile(
                    name: name,
                    age: age,
                    weight: weight,
                    userGender: gender,
                    height: height,
                  );
                  Navigator.of(context).pop(); // Tutup dialog jika valid
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blue[900],
        title: Row(
          children: [
            Image.asset(
              'assets/images/logogym.png',
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              'MUSCLE AI',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Spacer(),
            Switch(
              value: widget.isDarkMode,
              onChanged: widget.toggleDarkMode,
              activeColor: Colors.white,
              inactiveTrackColor: Colors.grey,
              inactiveThumbColor: Colors.white,
            ),
            Icon(
              widget.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: _selectedIndex != 4 ? _pages[_selectedIndex] : _pages[0],
      endDrawer: Drawer(
        child: Consumer<UserController>(
          builder: (context, userController, child) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userController.userName.isEmpty
                      ? "User Name"
                      : userController.userName),
                  accountEmail: Text(
                      _userEmail.isEmpty ? "user@example.com" : _userEmail),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      userController.userName.isEmpty
                          ? "U"
                          : userController.userName[0],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.blue[900]),
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile'),
                  onTap: () => _editProfile(context, userController),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                            toggleTheme: widget.toggleDarkMode,
                            isDarkMode: widget.isDarkMode),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(
                          isDarkMode: widget.isDarkMode,
                          toggleTheme: widget.toggleDarkMode,
                        ),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.auto_awesome),
                  title: Text('Predict Gemini'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeminiPredictPage(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () => _logout(context),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Workout'),
          BottomNavigationBarItem(
            icon: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(Icons.favorite, color: Colors.blue[900]),
            ),
            label: 'Health',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Activity Log'),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}