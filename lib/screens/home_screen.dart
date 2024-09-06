import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rootbound/screens/account_screen.dart';
import 'search_page.dart'; // Import the SearchPage
import 'location_details_screen.dart'; // Import the LocationDetailsScreen

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser; // Get the current user
  String selectedFilter = 'All'; // Start with 'All' or any default filter

  TextEditingController searchController =
      TextEditingController(); // Add search controller
  String searchQuery = ''; // Add search query

  @override
  Widget build(BuildContext context) {
    // Extract the username from the email
    String email = user?.email ?? 'guest@example.com';
    String username = email.split('@')[0];

    // Define images for each filter
    final List<ImageCardData> mostViewedImages = [
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
];

final List<ImageCardData> bestPicsImages = [
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
];

final List<ImageCardData> allImages = [
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/galle.png', 'Galle, Sri Lanka', '\$20 / Person'),
  ImageCardData('assets/sigiriya.png', 'Sigiriya, Sri Lanka', '\$20 / Person'),
];

    // Select images based on filter and search query
    List<ImageCardData> getDisplayedImages() {
      List<ImageCardData> filteredImages;

      switch (selectedFilter) {
        case 'Best pics':
          filteredImages = bestPicsImages;
          break;
        case 'Most viewed':
          filteredImages = mostViewedImages;
          break;
        case 'All':
        default:
          filteredImages = allImages;
          break;
      }

      // Apply search filtering
      if (searchQuery.isNotEmpty) {
        filteredImages = filteredImages
            .where((image) => image.location
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      }

      return filteredImages;
    }

    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Background color matching your design
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/user.png'), // Replace with actual image asset
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@$email',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004d40), // Green text color
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet consectetur.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value; // Update search query
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterButton(
                      label: 'All',
                      isSelected: selectedFilter == 'All',
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'All';
                        });
                      },
                    ),
                    FilterButton(
                      label: 'Best pics',
                      isSelected: selectedFilter == 'Best pics',
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'Best pics';
                        });
                      },
                    ),
                    FilterButton(
                      label: 'Most viewed',
                      isSelected: selectedFilter == 'Most viewed',
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'Most viewed';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Display the appropriate carousel based on the selected filter
                if (selectedFilter == 'Most viewed' || selectedFilter == 'All')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Most viewed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004d40),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200, // Height of the horizontal carousel
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: getDisplayedImages().length,
                          itemBuilder: (context, index) {
                            final data = getDisplayedImages()[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationDetailsScreen(),
                                    ),
                                  );
                                },
                                child: ImageCard(
                                  imageUrl: data.imageUrl,
                                  location: data.location,
                                  price: data.price,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                if (selectedFilter == 'Best pics' || selectedFilter == 'All')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best pics',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004d40),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200, // Height of the horizontal carousel
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: getDisplayedImages().length,
                          itemBuilder: (context, index) {
                            final data = getDisplayedImages()[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationDetailsScreen(),
                                    ),
                                  );
                                },
                                child: ImageCard(
                                  imageUrl: data.imageUrl,
                                  location: data.location,
                                  price: data.price,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Update the index based on the selected tab
        onTap: (index) {
          switch (index) {
            case 0:
              // Stay on the home page
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AccountScreen()), // Navigate to AccountScreen
              );
              break;
          }
        },
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
        selectedItemColor: Color(0xFF004d40), // Selected icon color
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  FilterButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Color(0xFF004d40) : Colors.grey[800], // Button color
        shape: StadiumBorder(),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String price;

  ImageCard({
    required this.imageUrl,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Set a fixed width for each card
      margin: EdgeInsets.only(right: 10), // Space between cards
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.asset(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004d40),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Icon(
                      Icons.location_pin,
                      size: 14,
                      color: Color(0xFF004d40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCardData {
  final String imageUrl;
  final String location;
  final String price;

  ImageCardData(this.imageUrl, this.location, this.price);
}
