import 'package:flutter/material.dart';

import '../../widgets/appabr_widget.dart';

class RolesPage extends StatelessWidget {
  PageController page = PageController();

  RolesPage({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(page),
    );
  }
}
