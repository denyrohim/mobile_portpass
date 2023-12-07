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
    this.padding,
  });

  final Color backgroundColor;
  final List<Widget> children;
  final Widget? header;
  final double? headerHeight;
  final double? mediaHeight;
  final double? padding;

  @override
  State<ContainerCard> createState() => _ContainerCardState();
}

class _ContainerCardState extends State<ContainerCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    (widget.mediaHeight ?? 0.8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  margin: widget.headerHeight != null
                      ? EdgeInsets.only(top: widget.headerHeight!)
                      : null,
                  child: ListView(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.padding ?? 10),
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
        ],
      ),
    );
  }
}
