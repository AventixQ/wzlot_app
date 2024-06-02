import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? selectedOptionBlock1;
  String? selectedOptionBlock2;
  String? selectedOptionBlock3;

  void selectOption(String option, int blockNumber) {
    setState(() {
      switch (blockNumber) {
        case 1:
          selectedOptionBlock1 = option;
          break;
        case 2:
          selectedOptionBlock2 = option;
          break;
        case 3:
          selectedOptionBlock3 = option;
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harmonogram atrakcji'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Wybierz zajęcia w Bloku nr 1", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              _buildOptionTile('Opcja 1', selectedOptionBlock1, 1),
              _buildOptionTile('Opcja 2', selectedOptionBlock1, 1),
              _buildOptionTile('Opcja 3', selectedOptionBlock1, 1),
              SizedBox(height: 20),
              Text("Wybierz zajęcia w Bloku nr 2", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              _buildOptionTile('Opcja 1', selectedOptionBlock2, 2),
              _buildOptionTile('Opcja 2', selectedOptionBlock2, 2),
              _buildOptionTile('Opcja 3', selectedOptionBlock2, 2),
              SizedBox(height: 20),
              Text("Wybierz zajęcia w Bloku nr 3", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              _buildOptionTile('Opcja 1', selectedOptionBlock3, 3),
              _buildOptionTile('Opcja 2', selectedOptionBlock3, 3),
              _buildOptionTile('Opcja 3', selectedOptionBlock3, 3),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(String option, String? selectedOption, int blockNumber) {
    bool isSelected = selectedOption == option;
    return GestureDetector(
      onTap: () {
        selectOption(option, blockNumber);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.orangeAccent : Colors.transparent,
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
