import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I CANYON TECHNOLOGIES'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Handle add button press
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildListItem('FRK Business Solutions Pvt Ltd', 'Delhi', 'Branding', 'Approved'),
                  _buildListItem('Aufait Technologies Pvt. Ltd.', 'Jaipur', 'Branding', 'Pending'),
                  _buildListItem('Cohesive IT Solutions LLP', 'Calicut', 'Branding', 'Approved'),
                  _buildListItem('Wikiflex Technologies LLP', 'Cochin', 'Branding', 'Rejected'),
                  _buildListItem('Technic IT IT Solutions', 'Chennai', 'Branding', 'Pending'),
                  _buildListItem('Voux Concepts Pvt.Ltd', 'Delhi', 'Branding', 'Approved'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String name, String location, String category, String status) {
    Color statusColor;

    switch (status) {
      case 'Approved':
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location),
            Text(category),
          ],
        ),
        trailing: Text(
          status,
          style: TextStyle(color: statusColor),
        ),
      ),
    );
  }
}