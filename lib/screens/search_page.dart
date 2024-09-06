import 'package:flutter/material.dart';
import 'package:rootbound/screens/location_details_screen.dart';
import 'package:rootbound/screens/home_screen.dart';
import 'package:rootbound/screens/account_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  int _selectedIndex = 1; // Index for the search page

  // The images will be fetched from the HomePage
  final List<ImageCardData> allImages = [
    ImageCardData('assets/image1.png', 'Dambulla, Sri Lanka', '\$20 / Person'),
    ImageCardData('assets/image1.png', 'Dambulla, Sri Lanka', '\$20 / Person'),
    ImageCardData('assets/image1.png', 'Dambulla, Sri Lanka', '\$20 / Person'),
    ImageCardData('assets/image1.png', 'Location 1', '\$25 / Person'),
    ImageCardData('assets/image1.png', 'Location 2', '\$30 / Person'),
    ImageCardData('assets/image1.png', 'Location 3', '\$35 / Person'),
    ImageCardData('assets/image1.png', 'Location 6', '\$50 / Person'),
    ImageCardData('assets/image1.png', 'Location 7', '\$55 / Person'),
    ImageCardData('assets/image1.png', 'Location 8', '\$60 / Person'),
    ImageCardData('assets/image1.png', 'Location 9', '\$65 / Person'),
    ImageCardData('assets/image1.png', 'Location 10', '\$70 / Person'),
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Your HomeScreen
        );
        break;
      case 1:
        // Do nothing since we're on the search page
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountScreen()), // Your AccountScreen
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ImageCardData> filteredImages = allImages
        .where((image) => image.location
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
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
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 20),
            if (filteredImages.isEmpty)
              Center(
                child: Text(
                  'No results found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8), // Padding on both sides
                  itemCount: filteredImages.length,
                  itemBuilder: (context, index) {
                    final data = filteredImages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20), // Increased bottom spacing
                      child: ImageCard(
                        imageUrl: data.imageUrl,
                        location: data.location,
                        price: data.price,
                      ),
                    );
                  },
                ),
              ),
          ],
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
        selectedItemColor: Colors.blue, // Color for the selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        onTap: _onItemTapped, // Handle navigation
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
    return GestureDetector(
      onTap: () {
        // Navigate to LocationDetailsScreen when the card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailsScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity, // Make the card width full-width within the padding
        height: 200, // Fixed height for each card
        margin: EdgeInsets.only(bottom: 10), // Space between cards
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
              child: Image.asset(
                imageUrl,
                height: 140, // Height of the image inside the card
                width: double.infinity,
                fit: BoxFit.cover,
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
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
