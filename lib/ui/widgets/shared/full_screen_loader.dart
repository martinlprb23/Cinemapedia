import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies',
      'Buying popcorn',
      'Buying ice cream',
      'Almost ready',
      'This is taking longer than expected :('
    ];

    return Stream.periodic(
            const Duration(microseconds: 1200), (step) => messages[step])
        .take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please wait'),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
