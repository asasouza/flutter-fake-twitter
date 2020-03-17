// flutter
import 'package:flutter/material.dart';
// helper
import '../helpers/colors.dart';

class TextInput extends StatefulWidget {
  final bool isPassword;
  final TextInputType keyboardType;
  final String label;

  TextInput({
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.label,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _contentHidden;
  bool _hasFocus = false;
  FocusNode _inputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _contentHidden = widget.isPassword;
    _inputFocus.addListener(() {
      setState(() {
        _hasFocus = _inputFocus.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Text(
          widget.label,
          style: TextStyle(
            color: ColorsHelper.darkGray,
            fontSize: 16,
          ),
        ),
        Stack(
          children: <Widget>[
            TextFormField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsHelper.darkGray,
                  ),
                ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Theme.of(context).accentColor,
                //     width: 2,
                //   ),
                // ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 7,
                  right: widget.isPassword ? 45 : 0,
                ),
              ),
              keyboardType: widget.keyboardType,
              obscureText: this._contentHidden,
              style: Theme.of(context).textTheme.body2,
              textCapitalization: TextCapitalization.none,
              focusNode: _inputFocus,
            ),
            if (widget.isPassword)
              Positioned(
                child: IconButton(
                  color: this._contentHidden
                      ? ColorsHelper.darkGray
                      : ColorsHelper.lightBlue,
                  icon: Icon(this._contentHidden
                      ? Icons.lock_outline
                      : Icons.lock_open),
                  onPressed: () {
                    setState(() {
                      this._contentHidden = !this._contentHidden;
                    });
                  },
                ),
                right: 0,
                top: -2,
                height: 30,
              ),
            AnimatedPositioned(
              bottom: -10,
              child: AnimatedContainer(
                color: this._hasFocus
                    ? ColorsHelper.lightBlue
                    : ColorsHelper.darkGray,
                curve: Curves.easeOut,
                duration: Duration(
                  milliseconds: 150,
                ),
                height: this._hasFocus ? 2 : 0,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: this._hasFocus ? deviceSize.width : 10,
              ),
              duration: Duration(
                milliseconds: 100,
              ),
              left: this._hasFocus ? 0 : deviceSize.width / 2,
            )
          ],
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
