import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 2; // Set default index to 'Profile'

  // Navigation based on the selected tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate to the Home page
      Navigator.pushNamed(
          context, '/home'); // Use pushNamed, not pushReplacement
    } else if (index == 1) {
      // Navigate to the Search page
      Navigator.pushNamed(
          context, '/search'); // Use pushNamed, not pushReplacement
    } else if (index == 2) {
      // Stay on the Profile page
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;

    // Extract username from email
    String username = user?.email?.split('@')[0] ?? 'Guest';

    // Sign out function
    Future<void> _signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        // Navigate back to the login screen after signing out
        Navigator.pushReplacementNamed(
            context, '/login'); // Only use pushReplacement for logout
      } catch (e) {
        // Handle sign out error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/user.png",
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16),
              Text(
                'Name: $username',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ${user?.email ?? 'No email'}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1B3D17), // Button color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Update with the selected index
        selectedItemColor: Colors.blue, // Color for the hovered/selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        onTap: _onItemTapped, // Handle navigation
      ),
    );
  }
}
