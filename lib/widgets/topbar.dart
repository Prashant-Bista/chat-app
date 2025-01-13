import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String _barTitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final double? fontsize;

  late double _deviceWidth;
  late double _deviceHeight;
   TopBar(this._barTitle,{super.key, this.primaryAction, this.secondaryAction, this.fontsize,});

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight= MediaQuery.of(context).size.height;

    return _buildUI();
  }
  Widget _buildUI(){
    return Container(
      height: _deviceHeight*0.10,
      width: _deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if(secondaryAction!=null) secondaryAction!,
          _titleBar(),
          if(primaryAction!=null) primaryAction!,

        ],
      ),
    );
  }
  Widget _titleBar(){
    return Text(_barTitle,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: fontsize,fontWeight: FontWeight.w700),);
  }
}
