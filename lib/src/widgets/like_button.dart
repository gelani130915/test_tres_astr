import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  bool isFavorite;
  LikeButton({Key? key, this.isFavorite = true}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  // bool _isFavorite = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isFavorite = !widget.isFavorite ;
        });
        _controller
            .reverse()
            .then((value) => _controller.forward());
      },
      child: ScaleTransition(
        scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: widget.isFavorite 
            ? Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black, spreadRadius: 0.2)],
                ),
              child: const CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.orange,
                ),
              ),
            )
            : Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black, spreadRadius: 0.2)],
                ),
              child: const CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                child: Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.black,
                      ),
              ),
            ),
      ),
    );
  }
}