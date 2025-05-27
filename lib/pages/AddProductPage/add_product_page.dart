import 'package:flutter/material.dart';
import '../../style_elements/custom_button.dart';
import '../../style_elements/custom_textfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Color _standardColor = Color.fromARGB(255, 130, 130, 255);

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String selectedValueType = '0';
  String selectedValueBuyer = '0';

  int selectedButtonIndex = 0;
  final TextEditingController _purchaseDateController = TextEditingController(
    text: DateFormat('dd.MM.yyyy').format(DateTime.now()),
  );

  final TextEditingController _saleDateController = TextEditingController(
    text: DateFormat('dd.MM.yyyy').format(DateTime.now()),
  );

  final TextEditingController _purchasePriceController =
  TextEditingController(text: "0");

  final TextEditingController _salePriceController =
  TextEditingController(text: "0");

  final TextEditingController _quantityController =
  TextEditingController(text: "1");

  // Состояние для ToggleButtons
  List<bool> isSelected = [true, false]; // Первая кнопка выбрана по умолчанию

  Future insertSold() async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase.from('products').insert([
        {
          'type_products': "Процессор",
          'name_products': 'Intel Core i7',
          'pricepurchase_products': _purchasePriceController.text,
          'count_products': _quantityController.text,
          'priceselling_products': _salePriceController.text,
          'datepurchase_products': _purchaseDateController.text,
          'forpc': "0",
          'buyer': 'Магазин',
        }
      ]);

      print('Данные успешно добавлены: $response');
    } catch (e) {
      print('Ошибка при добавлении данных: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Добавление товара",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: _standardColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              // Тип запчасти
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: buildTextFieldWithShadow(labelText: "Название"),
                  ),
                  SizedBox(width: 10), // Отступ между элементами
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Цвет тени
                            blurRadius: 10, // Размытие тени
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedValueType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueType = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: "0", child: Text("Процессор")),
                          DropdownMenuItem(value: "1", child: Text("Материнская плата")),
                          DropdownMenuItem(value: "2", child: Text("Видеокарта")),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none, // Убираем границы
                          labelText: "Тип запчасти",
                          labelStyle: TextStyle(
                            color: Colors.black54, // Цвет текста метки по умолчанию
                          ),
                          floatingLabelStyle: TextStyle(
                            color: _standardColor, // Цвет текста метки, когда поле в фокусе
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Кнопки "Для сборки" и "Для продажи" с ToggleButtons
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      onTap: () {
                        setState(() {
                          selectedButtonIndex = 0; // Выбираем "Для сборки"
                        });
                      },
                      child: Ink(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12
                            )
                          ],
                          color: selectedButtonIndex == 0 ? _standardColor : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Для сборки",
                            style: TextStyle(
                              color: selectedButtonIndex == 0 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      onTap: () {
                        setState(() {
                          selectedButtonIndex = 1; // Выбираем "Для продажи"
                        });
                      },
                      child: Ink(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12
                            )
                          ],
                          color: selectedButtonIndex == 1 ? _standardColor : Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Для продажи",
                            style: TextStyle(
                              color: selectedButtonIndex == 1 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Цена покупки и продажи
              buildTextFormFieldWithShadow(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _purchasePriceController,

                labelText: "Цена покупки",

              ),
              buildTextFormFieldWithShadow(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _salePriceController,

                labelText: "Цена для продажи",

              ),

              // Количество и дата покупки
              buildTextFormFieldWithShadow(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _quantityController,
                labelText: "Количество",

              ),
              buildDateTextField(
                context: context,
                controller: _purchaseDateController,
                labelText: "Дата покупки",
                standardColor: _standardColor,
              ),

              // Поле "Кто покупал?"
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Цвет тени
                            blurRadius: 10, // Размытие тени
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedValueBuyer,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueBuyer = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: "0", child: Text("Богдан")),
                          DropdownMenuItem(value: "1", child: Text("Максим")),
                          DropdownMenuItem(value: "2", child: Text("Магазин")),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none, // Убираем границы
                          labelText: "Покупатель",
                          labelStyle: TextStyle(
                            color: Colors.black54, // Цвет текста метки по умолчанию
                          ),
                          floatingLabelStyle: TextStyle(
                            color: _standardColor, // Цвет текста метки, когда поле в фокусе
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              // Кнопка "Добавить"
              SizedBox(
                child: createElevatedButton(
                  text: "Добавить",
                  onPressed: () {
                    insertSold(); // Вызов функции для вставки данных
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}