import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table_value.dart';

class NoteTableComponent extends StatelessWidget {
  final List<NoteTableValue> values;
  final double? height;
  final int? indexSelected;
  final void Function(int) onEditSelected;
  final void Function(int) onRemoveSelected;

  const NoteTableComponent({
    super.key,
    this.values = const [],
    this.height,
    this.indexSelected,
    required this.onEditSelected,
    required this.onRemoveSelected,
  });

  Map<int, TableColumnWidth> _generateColumnWidths(int numberOfColumns) {
    final Map<int, TableColumnWidth> widths = {};

    double totalWeight = 0;

    for (int i = 0; i < numberOfColumns; i++) {
      totalWeight += i % 3 == 2 ? 0.17 : 0.165;
    }

    for (int i = 0; i < numberOfColumns; i++) {
      double weight = i % 3 == 2 ? 0.17 : 0.165;

      widths[i] = FractionColumnWidth(weight / totalWeight);
    }

    return widths;
  }

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

  List<TableRow> _formatBody(int numberOfColumns, BuildContext context) {
    List<TableRow> tableRows = [];
    int totalRows = (values.length / numberOfColumns).ceil();

    for (int row = 0; row < totalRows; row++) {
      List<Widget> rowCells = [];
      for (int col = 0; col < numberOfColumns; col++) {
        int index = row * numberOfColumns + col;
        if (index < values.length) {
          var isSelected = index == indexSelected;

          rowCells.add(
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'edit') {
                  onEditSelected(index);
                } else if (value == 'delete') {
                  onRemoveSelected(index);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Editar'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Excluir'),
                  ),
                ),
              ],
              child: Material(
                color: isSelected? Colors.white54: Colors.white,
                elevation: isSelected ? 0: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          values[index].label ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            )
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

    int numberOfColumns = (screenWidth / 285).floor() * 3;
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Table(
              border: TableBorder.all(
                color: Colors.blue,
                width: 2,
                borderRadius: BorderRadius.circular(8),
              ),
              columnWidths: _generateColumnWidths(numberOfColumns),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue[100]),
                  children: _formatHeaders(numberOfColumns),
                ),
                ..._formatBody(numberOfColumns, context),
              ],
            ),
          )
        ),
      ),
    );
  }
}
