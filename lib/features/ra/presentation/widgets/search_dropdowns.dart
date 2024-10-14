// searchable_dropdown.dart
import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? selectedValue;
  final String hint;
  final Function(T?) onChanged;
  final String Function(T) itemLabel;

  SearchableDropdown({
    required this.label,
    required this.items,
    this.selectedValue,
    required this.hint,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(() {
      _filterItems();
    });
  }

  void _filterItems() {
    setState(() {
      _filteredItems = widget.items.where((item) {
        return widget.itemLabel(item)
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<T>(
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: widget.selectedValue,
          items: _filteredItems.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(widget.itemLabel(value)),
            );
          }).toList(),
          onChanged: widget.onChanged,
          hint: Text(widget.hint),
        ),
      ],
    );
  }
}
