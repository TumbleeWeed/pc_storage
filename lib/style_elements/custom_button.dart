import 'package:flutter/material.dart';
Color standardColor = Color.fromARGB(255, 130, 130, 255);

InkWell createElevatedButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.all(Radius.circular(15)),
    child: Ink(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Отступы для текста
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: standardColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16, // Размер текста
        ),
      ),
    ),
  );
}
OutlinedButton createOutlinedButton({
  required String text,
  required VoidCallback onPressed
})
{
  return OutlinedButton(
  onPressed: onPressed,
  child: Text(
    text,
    style: TextStyle(
      color: standardColor
    ),)
);
}