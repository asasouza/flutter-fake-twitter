// flutter
import 'package:flutter/material.dart';
// helper
import '../helpers/colors.dart';
import '../helpers/debounce.dart';

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
  final Function validator;

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
    this.validator,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _contentHidden;
  bool _hasFocus = false;
  bool _isValidating = false;
  String _isValid;
  FocusNode _inputFocus;
  DebounceHelper debounce = DebounceHelper();

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

  MaterialColor get _borderColor {
    if (_isValid != null) {
      return ColorsHelper.red;
    }
    if (_hasFocus) {
      return ColorsHelper.lightBlue;
    }
    return ColorsHelper.darkGray;
  }

  void _onChanged(String value) {
    if (widget.validator != null) {
      debounce.run(1000, () async {
        setState(() {
          _isValidating = true;
        });
        final error = await widget.validator(value);
        setState(() {
          _isValid = error;
          _isValidating = false;
        });
      });
    }
    widget.onChanged(value);
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
              buildCounter: (
                BuildContext context, {
                int currentLength,
                int maxLength = 0,
                bool isFocused,
              }) {
                return Text(
                  widget.maxLength != null
                      ? (maxLength - currentLength).toString()
                      : '',
                  style: TextStyle(
                    color: widget.maxLength != null &&
                            (maxLength - currentLength) < 0
                        ? ColorsHelper.red.shade800
                        : ColorsHelper.darkGray,
                    fontSize: 16,
                  ),
                );
              },
              controller: widget.controller,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  bottom: 7,
                  right: widget.isPassword ? 45 : 0,
                  top: 8,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsHelper.darkGray,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsHelper.red,
                  ),
                ),
                errorStyle: TextStyle(
                  color: ColorsHelper.red.shade800,
                  fontSize: 15,
                ),
                errorText: this._isValid,
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  color: ColorsHelper.darkGray,
                  fontSize: 18,
                ),
                isDense: true,
                suffix: this._isValidating
                    ? Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                        height: 15,
                        margin: EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        width: 15,
                      )
                    : null,
              ),
              focusNode: this._inputFocus,
              keyboardType: widget.keyboardType,
              obscureText: this._contentHidden,
              maxLength: widget.maxLength,
              maxLengthEnforced: false,
              onChanged: this._onChanged,
              onSaved: widget.onSave,
              onFieldSubmitted: widget.onFieldSubmitted,
              style: Theme.of(context).textTheme.body2,
              textCapitalization: TextCapitalization.none,
              textInputAction: widget.textInputAction,
            ),
            Positioned(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (widget.isPassword && !this._isValidating)
                    IconButton(
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
                ],
              ),
              right: 0,
              top: -2,
              height: 30,
            ),
            AnimatedPositioned(
              bottom: 15,
              child: AnimatedContainer(
                color: this._borderColor,
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
