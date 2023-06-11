import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';

class GridCard extends StatefulWidget {
  const GridCard({super.key});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                      "assets/food_sample2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor.withOpacity(0.4)),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFav ? isFav = false : isFav = true;
                        });
                      },
                      icon: isFav
                          ? const Icon(
                              Icons.favorite,
                              color: lightColor,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: lightColor,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        "\$20.6",
                        style: TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Veggie Bowl",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
