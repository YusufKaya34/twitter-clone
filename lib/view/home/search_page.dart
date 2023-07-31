import 'package:flutter/material.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/generated/locale_keys.g.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined))
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.account_circle_outlined),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white24,
        centerTitle: true,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            hintText: LocaleKeys.SearchPage_searchBarText.locale,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Color(0xFFB3B1B1),
            ),
            suffixIcon: const Opacity(
              opacity: 0,
              child: Icon(
                Icons.search,
                size: 26,
                color: Colors.black54,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45.0),
              borderSide: const BorderSide(
                width: 2.0,
                color: Color(0xFFFF0000),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45.0),
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.grey.shade200,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45.0),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
