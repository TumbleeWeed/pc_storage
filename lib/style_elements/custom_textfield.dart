import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
Color standardColor = Color.fromARGB(255, 130, 130, 255);

InputDecoration buildInputDecoration({
  required String labelText,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: standardColor, // Цвет границы, когда поле в фокусе
        width: 2.0,
      ),
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.black54, // Цвет текста метки по умолчанию
    ),
    floatingLabelStyle: TextStyle(
      color: standardColor, // Цвет текста метки, когда поле в фокусе
    ),
  );
}

Widget buildTextFieldWithShadow({
  required String labelText,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black54,
        ),
        floatingLabelStyle: TextStyle(
          color: standardColor,
        ),
      ),
    ),
  );
}

Widget buildTextFormFieldWithShadow({
  required String labelText,
  required TextInputType keyboardType,
  required List<TextInputFormatter>? inputFormatters,
  required TextEditingController controller,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
        ),
      ],
    ),
    child: TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black54,
        ),
        floatingLabelStyle: TextStyle(
          color: standardColor,
        ),
      ),
    ),
  );
}

InputDecoration buildDateInputDecoration({
  required String labelText,
  required Color standardColor,
  required VoidCallback onTap,
}) {
  return InputDecoration(
    filled: true, // Заливка фона
    fillColor: Colors.white, // Цвет фона
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide.none, // Убираем обводку
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide.none, // Убираем обводку в фокусе
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.black54, // Цвет текста метки по умолчанию
    ),
    floatingLabelStyle: TextStyle(
      color: standardColor, // Цвет текста метки, когда поле в фокусе
    ),
    suffixIcon: IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: onTap, // Открываем календарь при нажатии на иконку
    ),
  );
}

Widget buildDateTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  required Color standardColor,
}) {
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('dd.MM.yyyy').format(picked); // Форматируем выбранную дату
    }
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Цвет тени
          blurRadius: 10, // Размытие тени
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      decoration: buildDateInputDecoration(
        labelText: labelText,
        standardColor: standardColor,
        onTap: _selectDate,
      ),
      readOnly: true, // Запрещаем ручной ввод
    ),
  );
}