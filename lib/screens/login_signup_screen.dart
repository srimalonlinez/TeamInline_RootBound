import 'package:flutter/material.dart';
import 'package:rootbound/services/auth_service.dart';
import 'package:rootbound/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false; // Password visibility toggle
  bool _confirmPasswordVisible = false;

  // Instance of AuthService
  final AuthService _authService = AuthService();

  // Switch between Login and Sign-Up
  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  // Sign-Up Method
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      final user = await _authService.signUp(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Signed Up!')),
        );
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up Failed')),
        );
      }
    }
  }

  // Login Method
  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await _authService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Logged In!')),
        );
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed')),
        );
      }
    }
  }

  // Sign in with Google
  void _signInWithGoogle() async {
    User? user = await _authService.signInWithGoogle();
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully Signed In with Google!')),
      );
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Failed')),
      );
    }
  }

  // Sign in with Apple (To be implemented in AuthService)
  void _signInWithApple() async {
    // Implementation for Apple sign-in
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60), // Adjust to match the design's top margin
                Text(
                  'RootBound',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome To RootBound',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                Text(
                  'Lorem Ipsum Dolor Sit Amet Consectetur. At Massa Quam Nullam Parturient A Ac NisI Enim. Feugiat Tincidunt Metus Donec Scelerisque.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: isLogin ? null : toggleForm,
                      child: Column(
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  isLogin ? FontWeight.bold : FontWeight.normal,
                              color: isLogin ? Colors.black : Colors.grey,
                            ),
                          ),
                          if (isLogin)
                            Container(
                              height: 2,
                              width: 60,
                              color: Colors.black,
                              margin: const EdgeInsets.only(top: 4),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: isLogin ? toggleForm : null,
                      child: Column(
                        children: [
                          Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: !isLogin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: !isLogin ? Colors.black : Colors.grey,
                            ),
                          ),
                          if (!isLogin)
                            Container(
                              height: 2,
                              width: 60,
                              color: Colors.black,
                              margin: const EdgeInsets.only(top: 4),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                if (!isLogin)
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Email',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Password',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                if (!isLogin) ...[
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Your Password',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_confirmPasswordVisible,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment:
                        Alignment.centerLeft, // aligns to the start (left)
                    child: Text(
                      '• At least 8 characters\n• At least 1 number\n• Both upper and lower case characters',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.left, // Aligns the text to the left
                    ),
                  ),
                ],
                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password implementation
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: isLogin ? _login : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF193208), // Dark green button color
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    isLogin ? 'Login' : 'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Text color white
                    ),
                  ),
                ),

                SizedBox(height: 5), // Space between buttons and divider

                Text(
                  'Or ',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 5), // Sign in with Google Button
                ElevatedButton.icon(
                  onPressed: _signInWithGoogle,
                  icon: Image.asset(
                    'assets/google.png',
                    height: 24.0, // Set the height of the icon as needed
                    width: 24.0, // Set the width of the icon as needed
                  ),
                  label: Text(
                    'with Google',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4285F4), // Google Blue color
                    minimumSize: Size(double.infinity, 50), // Full-width button
                  ),
                ),

                SizedBox(height: 10),

                // Sign in with Apple Button
                ElevatedButton.icon(
                  onPressed: _signInWithApple,
                  icon: Icon(Icons.apple, color: Colors.white),
                  label: Text(
                    'with Apple',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Apple Black color
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Lorem Ipsum Dolor Sit Amet Consectetur. Aliquam Urna Mauris Neque Fames Netus.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
