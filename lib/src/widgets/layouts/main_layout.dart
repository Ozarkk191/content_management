import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Widget? appBar;
  final Widget? floatingActionButton;

  final bool loading;
  const MainLayout({
    super.key,
    required this.child,
    this.loading = false,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBar != null ? 60 : 0),
            child: Container(child: appBar),
          ),
          body: SafeArea(
            child: child,
          ),
          floatingActionButton: floatingActionButton,
        ),
        Visibility(
          visible: loading,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
