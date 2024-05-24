import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record_web/widgets/Web/search_list_widget.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final TextEditingController _searchController = TextEditingController();
  List searchResults = [];
  List results = [];

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
    searchFromFirebase();
  }

  void _onSearchChanged() {
    searchResultsList();
  }

  Future<void> searchFromFirebase() async {
    final res = await FirebaseFirestore.instance
        .collection('students')
        .orderBy('name')
        .get();

    if (mounted) {
      setState(() {
        searchResults = res.docs;
        searchResultsList();
      });
    }
  }

  @override
  void didChangeDependencies() {
    searchFromFirebase();
    super.didChangeDependencies();
  }

  searchResultsList() {
    List showResults = [];
    if (_searchController.text != "") {
      for (final clientshots in searchResults) {
        final name = clientshots['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientshots);
        }
      }
    } else {
      showResults = List.from(searchResults);
    }

    if (mounted) {
      setState(() {
        results = showResults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade300,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/texture.jpg'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) =>
                        SearchListTileWidget(results: results, index: index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
