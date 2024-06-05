import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  Color buttonColor ;

   CustomFormButton({
    Key? key,
    required this.innerText,
    required this.onPressed,
     this.buttonColor = const Color(0xff233743)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xff233743),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
