import 'package:flutter/material.dart';

enum Direction { LTR, RTL}

class SliderSideMenu extends StatefulWidget {

  final Color _controllerStartColor;  // side menu bg color when menu is collapsed
  final Color _controllerEndColor;  // side menu bg color when menu is expanded
  final List<MenuItem> _childrenData; // list of menu items
  final String _description;  // tooltip description, for A11y use
  final Direction _direction; // slide direction
  final Color _handleIconColor; // arrow icon color, this does not change with animation
  final Color _menuBackgroundColor; // background color of menu when expanded

  SliderSideMenu(
      {Color controllerStartColor = Colors.pinkAccent,
        Color controllerEndColor = Colors.teal,
        Color handleIconColor = Colors.white,
        Color menuBackgroundColor = Colors.teal,
        required List<MenuItem> childrenData,
        required String description,
      Direction direction = Direction.RTL})
      : _controllerStartColor = controllerStartColor,
        _controllerEndColor = controllerEndColor,
        _handleIconColor = handleIconColor,
        _menuBackgroundColor = menuBackgroundColor,
        _childrenData = childrenData,
        _description = description,
        _direction = direction;

  @override
  State<StatefulWidget> createState() {
    return _SliderSideMenuState();
  }
}

class MenuItem {
  final Function? onPressed;
  final Icon icon;
  final Widget label;

  MenuItem(this.icon, this.label, {this.onPressed});
}

class _SliderSideMenuState extends State<SliderSideMenu>
    with SingleTickerProviderStateMixin{
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  Animation<double>? _translateButton;
  Curve _curve = Curves.easeOut;

  final double viewHeight = 50;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 180 / 360).animate(_animationController);
    _buttonColor = ColorTween(
      begin: widget._controllerStartColor,
      end: widget._controllerEndColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Align(
      alignment: widget._direction == Direction.RTL ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
          width: 45,
          height: viewHeight,
          decoration: BoxDecoration(
              color: _buttonColor.value,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget._direction == Direction.RTL ? viewHeight : 0.0),
                  bottomLeft: Radius.circular(widget._direction == Direction.RTL ? viewHeight : 0.0),
                  topRight: Radius.circular(widget._direction == Direction.RTL ? 0.0 : viewHeight),
                  bottomRight: Radius.circular(widget._direction == Direction.RTL ? 0.0 : viewHeight))
          ),
          child: IconButton(
            icon: RotationTransition(
              turns: _animateIcon,
              child: Icon(widget._direction == Direction.RTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios, color: widget._handleIconColor,),
            ),
            onPressed: animate,
            tooltip: widget._description,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_translateButton == null) {
      _translateButton = Tween<double>(
        begin: widget._direction == Direction.RTL ? MediaQuery.of(context).size.width : -MediaQuery.of(context).size.width ,
        end: 0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.75,
          curve: _curve,
        ),
      ));
    }
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            _translateButton!.value,
            0.0,
            0.0,
          ),
          child: Container(
            color: widget._menuBackgroundColor,
            height: viewHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _generateMenuItems(),
            ),
          ),
      ),
        toggle()
      ],
    );
  }

  List<Widget> _generateMenuItems() {
    List<Widget> items = [];

    if (widget._childrenData.isNotEmpty) {
      for (int i = widget._childrenData.length; i > 0; i--) {
        items.add(_toMenuItemView(widget._childrenData[i - 1], i));
      }
    }

    items.add(_emptyItem());

    return items;
  }

  Widget _toMenuItemView(MenuItem item, int index) {
    return TextButton.icon(onPressed: () {
      animate();
      if (item.onPressed != null) {
        item.onPressed!();
      }
    }, icon: item.icon, label: item.label);
  }

  Widget _emptyItem() {
    return Container(
      width: 45,
    );
  }
}
