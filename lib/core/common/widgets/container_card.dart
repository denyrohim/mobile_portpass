import 'package:flutter/material.dart';

class ContainerCard extends StatefulWidget {
  const ContainerCard({
    super.key,
    this.backgroundColor = Colors.white,
    required this.children,
    this.header,
    this.mediaHeight,
  });

  final Color backgroundColor;
  final List<Widget> children;
  final Widget? header;
  final double? mediaHeight;

  @override
  State<ContainerCard> createState() => _ContainerCardState();
}

class _ContainerCardState extends State<ContainerCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(10),
        height:
            MediaQuery.of(context).size.height * (widget.mediaHeight ?? 0.8),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: widget.header,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
