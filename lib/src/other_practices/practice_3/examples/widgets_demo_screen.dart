import 'package:flutter/material.dart';

class WidgetsDemoScreen extends StatelessWidget {
  const WidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Васильев Игорь ИКБО-06-22")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text
            const Text(
              "Пример простого текста",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const Text(
              "Текст по центру с жирным шрифтом",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // ElevatedButton
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Кнопка нажата!")),
                );
              },
              child: const Text("Нажми меня"),
            ),
            const SizedBox(height: 20),

            const Text("Column (вертикальное расположение):"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Элемент 1"),
                Text("Элемент 2"),
                Text("Элемент 3"),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Row (горизонтальное расположение):"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Элемент 1"),
                Text("Элемент 2"),
                Text("Элемент 3"),
              ],
            ),
            const SizedBox(height: 20),

            // SizedBox
            const Text("Использование SizedBox:"),
            Container(
              color: Colors.grey[300],
              child: Column(
                children: const [
                  Text("Элемент сверху"),
                  SizedBox(height: 30),
                  Text("Элемент снизу"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Padding
            const Text("Использование Padding:"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Container(
                color: Colors.green[200],
                child: const Text("Контейнер с симметричными отступами"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Container(
                color: Colors.blue[200],
                child: const Text("Контейнер с выборочными отступами"),
              ),
            ),
            const SizedBox(height: 20),

            // Container
            const Text("Container с размерами и фоном:"),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Я — контейнер",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
