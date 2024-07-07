import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFF182871),
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: Colors.white,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('General settings'),
                    onTap: () {
                      // Navigate to General settings
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Tech used'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Tech Stack Used'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'Frontend Development: Utilized Flutter for creating a dynamic and responsive user interface.\n\n'
                                          'Backend Technologies: Employed Java with Spring Boot, integrating JPA and Hibernate for efficient data management with MySQL databases.\n\n'
                                          'Authentication: Progress made in implementing authentication via Spring Boot using JWT tokens, although full integration was hindered by time constraints.\n\n'
                                          'Advanced Features: Planned features included push notifications for service requests and automated email triggers to send PDF reports to staff emails.\n\n'
                                          'Project Scope: These features were considered as phase 3 enhancements, with partial completion achieved during the hackathon.'
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('About us'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('About Us'),
                            content: Text('Made by ShiroNeko999 and Malfito'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Log Out'),
                    onTap: () {
                      // Log out functionality
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Made for VOLVO',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
