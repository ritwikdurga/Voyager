// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:voyager/utils/constants.dart";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  const SelectedBorder();

  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    return const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)));   
  }
}

class _SearchState extends State<Search> {
  final SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        searchController: controller,
        viewBackgroundColor: Colors.black,
        viewSurfaceTintColor: Colors.black,
        isFullScreen: false,
        viewHintText: 'Where To?',
        headerTextStyle: TextStyle(color: Colors.white,),
        headerHintStyle: TextStyle(color:Colors.white),
        viewLeading: IconButton(
            onPressed: () {
              controller.clear();
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
              
            },
            icon: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        viewTrailing: [IconButton(onPressed: (){
          controller.clear();
                  }, icon: Icon(Icons.close,color: Colors.white,))],
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            shape:SelectedBorder(),
            controller: controller,
            focusNode: FocusNode(),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
              FocusScope.of(context).unfocus();
            },
            autoFocus: false,
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.openView();
              } else {
                controller.closeView(null);
              }
              FocusScope.of(context).unfocus();
            },
            leading: const Icon(Icons.search,color: Colors.white,),
            hintText: 'Where To?',
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            shadowColor: MaterialStateColor.resolveWith((states) => Colors.white),
            elevation: MaterialStateProperty.resolveWith((states) => 1),
            hintStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(
                color: Colors.white,
                fontFamily: 'ProductSans',
              ),
            ),
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(color: Colors.white,)),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<Widget>.generate(15, (int index) {
            final String item = 'item $index';
            return Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListTile(
                  title: Text(
                    item,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                      FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
