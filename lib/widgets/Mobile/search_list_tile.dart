import 'package:flutter/material.dart';
import 'package:student_record_web/widgets/Mobile/search_details_mobile.dart';

class SearchListTileMobileWidget extends StatefulWidget {
  const SearchListTileMobileWidget({
    super.key,
    required this.results,
    required this.index,
  });

  final List results;
  final int index;

  @override
  State<SearchListTileMobileWidget> createState() =>
      _SearchListTileMobileWidgetState();
}

class _SearchListTileMobileWidgetState
    extends State<SearchListTileMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.results[widget.index]['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
        ),
        onTap: () {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) => SearchDetailsMobileWidget(
                    index: widget.index,
                    results: widget.results,
                  ));
        },
        title: Text(widget.results[widget.index]['name']),
      ),
    );
  }
}
