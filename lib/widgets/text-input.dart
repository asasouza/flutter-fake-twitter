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

  @override
  void initState() {
    super.initState();
    _contentHidden = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
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
              obscureText: this._contentHidden,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsHelper.darkGray,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 7,
                  right: widget.isPassword ? 45 : 0,
                ),
              ),
              keyboardType: widget.keyboardType,
              style: Theme.of(context).textTheme.body2,
              textCapitalization: TextCapitalization.none,
              maxLines: 1,
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
                top: 0,
                height: 30,
              ),
          ],
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
