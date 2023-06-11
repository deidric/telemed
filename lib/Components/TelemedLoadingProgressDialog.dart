import 'package:flutter/material.dart';
import 'package:telemed/settings.dart';

class TelemedLoadingProgressDialog extends StatefulWidget {
  const TelemedLoadingProgressDialog({Key? key}) : super(key: key);

  @override
  State<TelemedLoadingProgressDialog> createState() =>
      _TelemedLoadingProgressDialogState();
}

class _TelemedLoadingProgressDialogState
    extends State<TelemedLoadingProgressDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child:Icon(Icons.medical_information)
          ),
          Text(TelemedSettings.loading),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RotationTransition(
              turns: _animation,
              child: const Icon(Icons.medical_information),
            ),
          ),
          Text(TelemedSettings.pleaseWait),
        ],
      ),
    );
  }
}
