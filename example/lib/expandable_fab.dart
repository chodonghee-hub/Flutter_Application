import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation.dart';

import 'action_button.dart';

const Duration _duration = Duration(milliseconds: 300);

class ExpandableFab extends StatefulWidget {
  final double distance;
  final List<Widget> children;

  const ExpandableFab(
      {Key? key, required this.distance, required this.children})
      : super(key: key);

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late bool _open = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimaton;

  @override
  void initState() {
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: _duration,
      vsync: this,
    );
    _expandAnimaton =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _buildTabToCloseFab(),
          _buildTabToOpenFab(),
        ]..insertAll(0, _buildExpandableActionButton()),
      ),
    );
  }


  List<_ExpandableActionbutton> _buildExpandableActionButton() {
    List<_ExpandableActionbutton> animChildren = [];

    final int count = widget.children.length;
    final double gap = 90.0 / (count - 1);

    for(var i=0, degree = 0.0; i < count; i++, degree += gap) {

      animChildren.add(_ExpandableActionbutton(
          distance: widget.distance,
          progress: _expandAnimaton,
          child: widget.children[i],
          degree: degree,
        ));
      }
    return animChildren;
    }

  AnimatedContainer _buildTabToCloseFab() {
    return AnimatedContainer(
      transformAlignment: Alignment.center,
      duration: _duration,
      transform: Matrix4.rotationZ(_open ? 0 : pi / 4),
      child: FloatingActionButton(
        backgroundColor: Color.fromRGBO(110, 110, 140, 1),
        onPressed: toggle,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  AnimatedContainer _buildTabToOpenFab() {
    return AnimatedContainer(
      transformAlignment: Alignment.center,
      duration: _duration,
      transform: Matrix4.rotationZ(_open ? 0 : pi / 4),
      child: AnimatedOpacity(
        duration: _duration,
        opacity: _open ? 0.0 : 1.0, //투명함
        child: FloatingActionButton(
          onPressed: toggle,
          child: Icon(Icons.close),
        ),
      ),
    );
  }

  void toggle() {
    _open = !_open;
    setState(() {
      if (_open)
        _controller.forward();
      else
        _controller.reverse();
    });
  }
}

class _ExpandableActionbutton extends StatelessWidget {
  final double distance;
  final double degree;
  final Animation<double> progress;
  final Widget child;

  const _ExpandableActionbutton(
      {
      required this.distance,
      required this.degree,
      required this.progress,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: progress,
        builder: (context, child) {
          final Offset offset = Offset.fromDirection(
              degree * (pi / 180), progress.value * distance);
          return Positioned(
            right: offset.dx+4,
            bottom: offset.dy+4,
            child: this.child,
          );
        },
        child: child);
  }
}
