import 'package:flutter/material.dart';

class SearchDetailsWidget extends StatefulWidget {
  final List results;
  final int index;
  const SearchDetailsWidget(
      {super.key, required this.results, required this.index});

  @override
  State<SearchDetailsWidget> createState() => _SearchDetailsWidgetState();
}

class _SearchDetailsWidgetState extends State<SearchDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('More Details'),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.cancel_outlined),
            color: Colors.black,
            iconSize: 40,
          )
        ],
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onDoubleTap: () => showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.results[widget.index]['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
                              fit: BoxFit.fitHeight)),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.cancel_outlined),
                      color: Colors.white,
                      iconSize: 40,
                    )
                  ],
                ),
              ),
            ),
            child: SizedBox(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/student-logbook-58249.appspot.com/o/StudentImages%2F${widget.results[widget.index]['path']}?alt=media&token=114dd2fb-eeec-4883-9105-eccca3528708'),
            )),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Name : ${widget.results[widget.index]['name']}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Age : ${widget.results[widget.index]['age']}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Email : ${widget.results[widget.index]['email']}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Batch : ${widget.results[widget.index]['domain']}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
