import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: RefreshProgressIndicator(
          strokeWidth: 3,
          color: Color.fromRGBO(3, 37, 65, 1),
        ),
      ),
    );
  }
}
