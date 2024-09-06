RootBound

RootBound is a Flutter application designed to help users explore and book locations. This app integrates Firebase for authentication and uses Google Sign-In for an enhanced login experience.
Features
•	User Authentication: Sign up, sign in, and sign out with email/password and Google.
•	Location Search: Search for locations and view details about each one.
•	Location Booking: Book locations directly through the app.
Screens
•	Login/Sign-Up Screen: Allows users to sign in or create an account.
•	Home Screen: Displays a list of locations.
•	Search Page: Provides a search bar to filter locations.
•	Location Details Screen: Shows detailed information about a selected location.
•	Account Screen: Displays user information and allows sign-out.

Installation
1.	Clone the Repository
    git clone https://github.com/srimalonlinez/TeamInline_RootBound.git
2.	Navigate to the Project Directory
    cd rootbound
3.	Install Dependencies
    Make sure you have Flutter installed. Run the following command to install the required packages:
    flutter pub get
4.	Configure Firebase
Follow these steps to set up Firebase:
  o	Go to the Firebase Console.
  o	Create a new project or use an existing one.
  o	Add your Android app to the project and download the google-services.json file.
  o	Place the google-services.json file in the android/app directory.
  o	Follow the Firebase setup instructions for Android in the Firebase documentation.
5.	Run the App
Connect a device or start an emulator and run:
flutter run

Usage
•	Sign Up: Create a new account using email and password.
•	Sign In: Log in with your email and password or Google account.
•	Search Locations: Use the search bar on the search page to find locations.
•	View Details: Tap on a location card to view detailed information.
•	Book Location: Click the "Book Now" button to book a location.

Project Structure
•	lib/: Contains the main application code.
o	screens/: Contains the different screens in the app.
	login_signup_screen.dart: Sign in and sign-up screen.
	home_screen.dart: Home screen displaying the list of locations.
	search_page.dart: Page with search functionality.
	location_details_screen.dart: Details of a selected location.
	account_screen.dart: User account information and sign-out functionality.
o	services/: Contains services for authentication.
	auth_service.dart: Handles Firebase authentication operations.

Contributing
Contributions are welcome! Please follow these steps to contribute:
1.	Fork the repository.
2.	Create a new branch for your feature or bug fix.
3.	Commit your changes and push to your branch.
4.	Create a pull request with a clear description of your changes.

License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact: For any questions or feedback, please contact srimaltharupathionline@gmail.com
