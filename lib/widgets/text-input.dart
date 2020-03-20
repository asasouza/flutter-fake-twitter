// flutter
import 'package:flutter/material.dart';
// helper
import '../helpers/colors.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPassword;
  final TextInputType keyboardType;
  final String label;
  final int maxLength;
  final Function onChanged;
  final Function onFieldSubmitted;
  final Function onSave;
  final String placeholder;
  final TextInputAction textInputAction;

  TextInput({
    this.controller,
    this.focusNode,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.label,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSave,
    this.placeholder,
    this.textInputAction,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _contentHidden;
  bool _hasFocus = false;
  FocusNode _inputFocus;

  @override
  void initState() {
    super.initState();
    _contentHidden = widget.isPassword;
    _inputFocus = widget.focusNode != null ? widget.focusNode : FocusNode();
    _inputFocus.addListener(() {
      setState(() {
        _hasFocus = _inputFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inputFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        if (widget.label != null)
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
              controller: widget.controller,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsHelper.darkGray,
                  ),
                ),
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: ColorsHelper.darkGray,
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 7,
                  right: widget.isPassword ? 45 : 0,
                ),
              ),
              focusNode: this._inputFocus,
              keyboardType: widget.keyboardType,
              obscureText: this._contentHidden,
              // maxLength: widget.maxLength,
              // maxLengthEnforced: true,
              onChanged: widget.onChanged,
              onSaved: widget.onSave,
              onFieldSubmitted: widget.onFieldSubmitted,
              style: Theme.of(context).textTheme.body2,
              textCapitalization: TextCapitalization.none,
              textInputAction: widget.textInputAction,
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
        if (widget.maxLength != null)
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              widget.maxLength.toString(),
              style: TextStyle(
                color: ColorsHelper.darkGray,
                fontSize: 16,
              ),
            ),
            margin: EdgeInsetsDirectional.only(
              top: 5,
            ),
          ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
