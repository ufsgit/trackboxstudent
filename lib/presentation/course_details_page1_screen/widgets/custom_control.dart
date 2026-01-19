import 'package:flutter/material.dart';

class CombinedControls extends StatelessWidget {
  final Widget defaultControls;
  final VoidCallback onFastForward;

  CombinedControls(
      {required this.defaultControls, required this.onFastForward});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Default controls
        defaultControls,
        // Custom controls on top
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.forward_10, color: Colors.white),
                  onPressed: onFastForward,
                ),
                // Add more custom controls here if needed
              ],
            ),
          ),
        ),
      ],
    );
  }
}
