// External
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';

// Internal
import './drawer.dart';

class PageWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final List<Widget> children;
  final String title;

  PageWidget({
      required this.children,
      this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xFF2fc4c4),
            image: DecorationImage(
              image: AssetImage(
                "assets/img/hex.png",
              ),
              scale: constraints.maxWidth < 600 ? 1 : 1,
              fit: BoxFit.none,
            ),            
          ),
          child: Container(
            child: Scaffold(
              key: _globalKey,
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              drawer: AppDrawer(),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Center(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: 600,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight / 2,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: children,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
