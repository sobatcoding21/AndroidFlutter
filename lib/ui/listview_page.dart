import 'package:flutter/material.dart';

class ListKota extends StatelessWidget {
  const ListKota({Key? key, required this.nama}) : super(key: key);

  final String nama;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:
            Text(nama.toString(), style: const TextStyle(fontSize: 18.0)),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade400,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.edit))),
              const SizedBox(width: 5),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.delete)))
            ]),
      ),
    );
  }
}