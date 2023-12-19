import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteButtons extends StatefulWidget {
  const FavoriteButtons({super.key});

  @override
  State<FavoriteButtons> createState() => _FavoriteButtonsState();
}

class _FavoriteButtonsState extends State<FavoriteButtons> {

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "1500 TL",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 25,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;  // İkona tıklandığında favori durumunu değiştir
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey, // Favori durumuna göre ikonu değiştir
              size: 25,
            ),
          ),
        )
      ],
    );
  }
}
