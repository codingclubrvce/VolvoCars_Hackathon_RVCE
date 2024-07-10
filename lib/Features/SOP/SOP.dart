import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Carousel',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card Carousel'),
        ),
        body: Center(
          child: CardCarousel(),
        ),
      ),
    );
  }
}

class CardCarousel extends StatefulWidget {
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  double _currentPage = 0.0;

  List<String> imageUrls = [
    'https://www.volvocars.com/images/v/-/media/applications/pdpspecificationpage/my24/xc40-electric/pdp/xc40-bev-hero-4x3.jpg?iar=0&w=720',
    'https://www.volvocars.com/images/v/-/media/applications/pdpspecificationpage/my24/xc90-fuel/pdp/xc90-fuel-hero-4x3.jpg?iar=0&w=720',
    'https://www.volvocars.com/images/v/-/media/applications/pdpspecificationpage/my24/c40-electric/pdp/c40-bev-hero-4x3.jpg?iar=0&w=720',
    'https://www.volvocars.com/images/v/-/media/applications/pdpspecificationpage/my24/xc60-fuel/pdp/xc60-fuel-hero-4x3.jpg?iar=0&w=720',
    'https://www.volvocars.com/images/v/-/media/applications/pdpspecificationpage/my24/s90-fuel/pdp/s90-fuel-hero-21x9.jpg?iar=0&w=1920',
  ];

  List<String> titles = [
    'XC40',
    'XC90',
    'C40',
    'XC60',
    'S90',
  ];

  List<String> descriptions = [
    'Cycle Time for Operations (in minutes)\nKitting: 15\nPower pack: 25\nDecking: 25\nTrim: 20\nMedia/SIP: 20',
    'Cycle Time for Operations (in minutes)\nKitting: 15\nPower pack: 25\nDecking: 25\nTrim: 20\nMedia/SIP: 20',
    'Cycle Time for Operations (in minutes)\nKitting: 10\nPower pack: 15\nDecking: 20\nTrim: 10\nMedia/SIP: 10',
    'Cycle Time for Operations (in minutes)\nKitting: 15\nPower pack: 20\nDecking: 20\nTrim: 15\nMedia/SIP: 20',
    'Cycle Time for Operations (in minutes)\nKitting: 20\nPower pack: 25\nDecking: 25\nTrim: 20\nMedia/SIP: 20',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: 5, // Number of cards to display
      itemBuilder: (context, index) {
        double scale = 1.0;
        if (_pageController.position.haveDimensions) {
          scale = (_pageController.page! - index).abs() < 1
              ? 1.0 - (_pageController.page! - index).abs() * 0.3
              : 0.7;
        }
        return Transform.scale(
          scale: scale,
          child: RoundedImageCard(
            imageUrl: imageUrls[index],
            title: titles[index],
            description: descriptions[index],
          ),
        );
      },
    );
  }
}

class RoundedImageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  RoundedImageCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.network(
                  imageUrl,
                  width: 175,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}