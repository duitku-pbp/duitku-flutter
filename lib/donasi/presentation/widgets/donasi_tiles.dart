import 'package:duitku/donasi/data/models/donasi.dart';
import 'package:flutter/material.dart';

class DonasiTiles extends StatelessWidget {
  final List<Donasi> donasi;

  const DonasiTiles({super.key, required this.donasi});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: i == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )
                : i == donasi.length - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )
                    : BorderRadius.circular(0),
          ),
          child: ListTile(
            title: Text(
            donasi[i].name,
            style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              "Rp. ${donasi[i].amount}",
              style: const TextStyle(fontSize: 18),
            ),
            trailing: Text(
              donasi[i].target,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        itemCount: donasi.length,
      ),
    );
  }
}
