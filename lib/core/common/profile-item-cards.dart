import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildListTile(
    BuildContext context, String title, IconData icon, VoidCallback onTap) {
  return Card(
    color: Color.fromRGBO(0, 103, 176, 0.05), // Background color
    elevation: 0, // Removes the shadow
    margin: EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
        shadows: [
          Shadow(
            blurRadius: 1,
            color: Colors.black,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      onTap: onTap,
    ),
  );
}