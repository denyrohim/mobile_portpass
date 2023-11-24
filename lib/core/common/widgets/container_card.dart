import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class ContainerCard extends StatefulWidget {
  const ContainerCard({
    super.key,
    this.backgroundColor = Colours.secondaryColour,
    required this.children,
    this.header,
    this.mediaHeight,
    this.headerHeight,
  });

  final Color backgroundColor;
  final List<Widget> children;
  final Widget? header;
  final double? headerHeight;
  final double? mediaHeight;

  @override
  State<ContainerCard> createState() => _ContainerCardState();
}

class _ContainerCardState extends State<ContainerCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: widget.headerHeight != null
                      ? EdgeInsets.only(top: widget.headerHeight!)
                      : null,
                  height: MediaQuery.of(context).size.height *
                      (widget.mediaHeight ?? 0.8),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: widget.children,
                    ),
                  ),
                ),
                if (widget.header != null)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: widget.header,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
