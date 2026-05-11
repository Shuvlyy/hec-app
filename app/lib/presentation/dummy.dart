import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hec_app/core/constants.dart';
import 'package:native_glass_navbar/native_glass_navbar.dart';

class Dummy extends StatefulWidget
{
  const Dummy({ super.key });

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy>
{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(Constants.appName),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('hilol'),
                  ],
                ),
              ),
            ),
          ),
          const CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
            child: SafeArea(
              child: Center(child: Text('Settings go here!')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NativeGlassNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: const [
          NativeGlassNavBarItem(label: 'Home', symbol: 'house'),
          NativeGlassNavBarItem(label: 'Settings', symbol: 'gear'),
        ],
        fallback: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
