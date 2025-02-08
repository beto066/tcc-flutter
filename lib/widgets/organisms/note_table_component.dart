import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';

class NoteTableComponent extends StatelessWidget {
  final void Function(int) selectedTableValue;
  final double? height;
  final List<NoteTableValue> values;

  const NoteTableComponent({super.key, required this.selectedTableValue, this.height, this.values = const []});

  List<Widget> _formatHeaders(int numberOfColumns) {
    List<Widget> tableHeaders = [];
    for (int i = 0; i < numberOfColumns; i++) {
      if ((i + 1) % 3 == 0) {
        tableHeaders.add(
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.star,
              color: Colors.blue,
              size: 19,
            ),
          ),
        );
      } else {
        tableHeaders.add(
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "_",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return tableHeaders;
  }

  List<TableRow> _formatBody(int numberOfColumns) {
    List<TableRow> tableRows = [];
    int totalRows = (values.length / numberOfColumns).ceil();

    for (int row = 0; row < totalRows; row++) {
      List<Widget> rowCells = [];
      for (int col = 0; col < numberOfColumns; col++) {
        int index = row * numberOfColumns + col;
        if (index < values.length) {
          rowCells.add(
            ButtonTile(
              values[index].label,
              textAlign: TextAlign.center,
              onTap: () {
                selectedTableValue(index);
              },
            ),
          );
        } else {
          rowCells.add(Container());
        }
      }
      tableRows.add(TableRow(children: rowCells));
    }

    return tableRows;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int numberOfColumns = (screenWidth / 200).floor() * 3;
    numberOfColumns = numberOfColumns < 3 ? 3 : numberOfColumns;

    return SizedBox(
      width: screenWidth,
      height: height ?? MediaQuery.of(context).size.height - 150,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(
              color: Colors.blue,
              width: 2,
              borderRadius: BorderRadius.circular(8),
            ),
            columnWidths: const {
              0: FractionColumnWidth(0.165),
              1: FractionColumnWidth(0.165),
              2: FractionColumnWidth(0.17),
              3: FractionColumnWidth(0.165),
              4: FractionColumnWidth(0.165),
              5: FractionColumnWidth(0.17),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.blue[100]),
                children: _formatHeaders(numberOfColumns),
              ),
              ..._formatBody(numberOfColumns),
            ],
          ),
        ),
      ),
    );
  }
}