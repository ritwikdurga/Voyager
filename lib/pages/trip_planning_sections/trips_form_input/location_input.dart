import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/places.dart';
import 'package:voyager/utils/constants.dart';

class LocationInput extends StatefulWidget {
  final Function(String)? onLocationSelected;
  String? initialLocation;
  LocationInput({Key? key, this.onLocationSelected, this.initialLocation})
      : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput>
    with AutomaticKeepAliveClientMixin {
  List<String> suggestions = List.from(places);
  TextEditingController _searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  void _onSearchChanged() {
    setState(() {
      suggestions = _filterSuggestions(_searchController.text);
    });
  }

  List<String> _filterSuggestions(String query) {
    return query.isEmpty
        ? List.from(places)
        : suggestions
            .where((location) =>
                location.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        const Text(
          'Where do you want to go?',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.grey[800]
                  : Colors.grey[300],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Your logic for suggestions based on user input
                _onSearchChanged();
              },
              decoration: InputDecoration(
                hintText: 'Search places...',
                prefixIcon: Icon(Icons.location_on),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.5),
                child: ListTile(
                  leading: Icon(Iconsax.location),
                  title: Text(suggestions[index]),
                  onTap: () {
                    _searchController.text = suggestions[index];
                    if (widget.onLocationSelected != null) {
                      widget.onLocationSelected!(suggestions[index]);
                    }
                    suggestions.clear();
                    setState(() {});
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
