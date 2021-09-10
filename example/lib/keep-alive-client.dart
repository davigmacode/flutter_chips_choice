import 'package:flutter/widgets.dart';

class KeepAliveClient extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  KeepAliveClient({
    Key? key,
    required this.child,
    this.keepAlive = true,
  }) : super(key: key);

  @override
  _KeepAliveClientState createState() => _KeepAliveClientState();
}

class _KeepAliveClientState extends State<KeepAliveClient>
    with AutomaticKeepAliveClientMixin<KeepAliveClient> {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
