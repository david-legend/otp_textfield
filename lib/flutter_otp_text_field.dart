library flutter_otp_text_field;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnCodeEnteredCompletion = void Function(String value);
typedef OnCodeChanged = void Function(String value);
typedef HandleControllers = void Function(List<TextEditingController?> controllers);

// ignore: must_be_immutable
class OtpTextField extends StatefulWidget {
  /// allows to show or disable cursor
  final bool showCursor;

  /// specify number of fields, defaults to 4
  final int numberOfFields;

  /// width of each text field
  final double fieldWidth;

  /// height of each text field
  final double? fieldHeight;

  /// border width of each text field
  final double borderWidth;

  /// aligns text fields in container
  final Alignment? alignment;

  /// color of enabled border
  final Color enabledBorderColor;

  /// color of focused border
  final Color focusedBorderColor;

  /// color of disabled border
  final Color disabledBorderColor;

  /// handles color of border
  final Color borderColor;

  /// handles color of cursor
  final Color? cursorColor;

  /// handles margin in between text fields
  final EdgeInsetsGeometry margin;

  /// controls keyboard type
  final TextInputType keyboardType;

  /// handles textStyle of digit in textField
  final TextStyle? textStyle;

  /// handles mainAxisAlignment of textFields in Row
  final MainAxisAlignment mainAxisAlignment;

  /// handles crossAxisAlignment of textFields in Row
  final CrossAxisAlignment crossAxisAlignment;

  /// callBack called when last textField is filled
  final OnCodeEnteredCompletion? onSubmit;

  /// callBack called when code in textField changes
  final OnCodeEnteredCompletion? onCodeChanged;

  /// textEditing controller handler
  final HandleControllers? handleControllers;

  /// handles visibility of text in textField
  final bool obscureText;

  /// if true, uses outlineBorder, if false underlineBorder
  final bool showFieldAsBox;

  /// if true, sets textFields to enabled
  final bool enabled;

  /// If true the decoration's container is filled with [fillColor].
  final bool filled;

  /// handles autoFocus
  final bool autoFocus;

  /// if true, sets content of textField to be readOnly
  final bool readOnly;

  /// clears text
  bool clearText;

  /// if true, custom Input decoration that is passed in takes effect
  final bool hasCustomInputDecoration;

  /// sets fill color of textField
  final Color fillColor;

  /// sets borderRadius of textField
  final BorderRadius borderRadius;

  /// sets InputDecoration
  final InputDecoration? decoration;

  /// sets custom styles for textFields
  final List<TextStyle?> styles;

  /// sets inputFormatters for textFields
  final List<TextInputFormatter>? inputFormatters;

  /// handles contentPadding for each textField
  final EdgeInsetsGeometry? contentPadding;

  OtpTextField({
    this.showCursor = true,
    this.numberOfFields = 4,
    this.fieldWidth = 40.0,
    this.fieldHeight,
    this.alignment,
    this.margin = const EdgeInsets.only(right: 8.0),
    this.textStyle,
    this.clearText = false,
    this.styles = const [],
    this.keyboardType = TextInputType.number,
    this.borderWidth = 2.0,
    this.cursorColor,
    this.disabledBorderColor = const Color(0xFFE7E7E7),
    this.enabledBorderColor = const Color(0xFFE7E7E7),
    this.borderColor = const Color(0xFFE7E7E7),
    this.focusedBorderColor = const Color(0xFF4F44FF),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.handleControllers,
    this.onSubmit,
    this.obscureText = false,
    this.showFieldAsBox = false,
    this.enabled = true,
    this.autoFocus = false,
    this.hasCustomInputDecoration = false,
    this.filled = false,
    this.fillColor = const Color(0xFFFFFFFF),
    this.readOnly = false,
    this.decoration,
    this.onCodeChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.inputFormatters,
    this.contentPadding,
  })  : assert(numberOfFields > 0),
        assert(styles.isNotEmpty ? styles.length == numberOfFields : styles.isEmpty);

  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late List<String?> _verificationCode;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  @override
  void initState() {
    super.initState();

    _verificationCode = List<String?>.filled(widget.numberOfFields, null);
    _focusNodes = List<FocusNode?>.filled(widget.numberOfFields, null);
    _textControllers = List<TextEditingController?>.filled(
      widget.numberOfFields,
      null,
    );
  }

  @override
  void didUpdateWidget(covariant OtpTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clearText != widget.clearText && widget.clearText == true) {
      for (var controller in _textControllers) {
        controller?.clear();
      }
      _verificationCode = List<String?>.filled(widget.numberOfFields, null);
      setState(() {
        widget.clearText = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textControllers.forEach((TextEditingController? controller) => controller?.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return _generateTextFields(context);
  }

  Widget _buildTextField({
    required BuildContext context,
    required int index,
    TextStyle? style,
  }) {
    return Container(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      alignment: widget.alignment,
      margin: widget.margin,
      child: TextFormField(
        showCursor: widget.showCursor,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        maxLength: widget.numberOfFields,
        readOnly: widget.readOnly,
        style: style ?? widget.textStyle,
        autofocus: widget.autoFocus,
        cursorColor: widget.cursorColor,
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        decoration: widget.hasCustomInputDecoration
            ? widget.decoration
            : InputDecoration(
                counterText: "",
                filled: widget.filled,
                fillColor: widget.fillColor,
                focusedBorder: widget.showFieldAsBox
                    ? _outlineBorder(widget.focusedBorderColor)
                    : _underlineInputBorder(widget.focusedBorderColor),
                enabledBorder: widget.showFieldAsBox
                    ? _outlineBorder(widget.enabledBorderColor)
                    : _underlineInputBorder(widget.enabledBorderColor),
                disabledBorder: widget.showFieldAsBox
                    ? _outlineBorder(widget.disabledBorderColor)
                    : _underlineInputBorder(widget.disabledBorderColor),
                border: widget.showFieldAsBox
                    ? _outlineBorder(widget.borderColor)
                    : _underlineInputBorder(widget.borderColor),
                contentPadding: widget.contentPadding,
              ),
        obscureText: widget.obscureText,
        onChanged: (String value) {
          if (value.length <= 1) {
            _verificationCode[index] = value;
            _onDigitEntered(value, index);
          } else {
            _handlePaste(value, index);
          }
        },
      ),
    );
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: color,
      ),
      borderRadius: widget.borderRadius,
    );
  }

  UnderlineInputBorder _underlineInputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: widget.borderWidth,
      ),
    );
  }

  Widget _generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.numberOfFields, (int i) {
      _addFocusNodeToEachTextField(index: i);
      _addTextEditingControllerToEachTextField(index: i);

      if (widget.styles.isNotEmpty) {
        return _buildTextField(
          context: context,
          index: i,
          style: widget.styles[i],
        );
      }
      if (widget.handleControllers != null) {
        widget.handleControllers!(_textControllers);
      }
      return _buildTextField(context: context, index: i);
    });

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: textFields,
    );
  }

  void _addFocusNodeToEachTextField({required int index}) {
    if (_focusNodes[index] == null) {
      _focusNodes[index] = FocusNode();
    }
  }

  void _addTextEditingControllerToEachTextField({required int index}) {
    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();

      _textControllers[index]!.addListener(() {
        String text = _textControllers[index]!.text;
        if (text.isEmpty) {
          // Handle backspace by moving focus to the previous field
          _changeFocusToPreviousNode(index);
        }
      });
    }
  }

  void _changeFocusToPreviousNode(int index) {
    try {
      if (index > 0 && index < widget.numberOfFields) {
        _focusNodes[index - 1]?.requestFocus();
      }
    } catch (e) {
      // Log an error if focus cannot be moved
      log('Cannot focus on the previous field');
    }
  }

  void _changeFocusToNextNodeWhenValueIsEntered({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      //if the textField in focus is not the last textField,
      // change focus to the next textField
      if (indexOfTextField + 1 != widget.numberOfFields) {
        //change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        //if the textField in focus is the last textField, unFocus after text changed
        _focusNodes[indexOfTextField]?.unfocus();
      }
    }
  }

  void _onSubmit({required List<String?> verificationCode}) {
    if (verificationCode.every((String? code) => code != null && code != '')) {
      if (widget.onSubmit != null) {
        widget.onSubmit!(verificationCode.join());
      }
    }
  }

  void _onCodeChanged({required String verificationCode}) {
    if (widget.onCodeChanged != null) {
      widget.onCodeChanged!(verificationCode);
    }
  }

  _onDigitEntered(String digit, int index) {
    _onCodeChanged(verificationCode: digit);
    _changeFocusToNextNodeWhenValueIsEntered(
      value: digit,
      indexOfTextField: index,
    );
    setState(() {
      _onSubmit(verificationCode: _verificationCode);
    });
  }

  /// this is called when a particular text field has more than one character
  /// this will normally happen in 2 instances
  /// 1. when a user pastes a string in the text field
  /// 2. when a user types more than one character in a field
  _handlePaste(String str, int index) {
    if (str.length > widget.numberOfFields) {
      str = str.substring(0, widget.numberOfFields);
    }

    int textFieldIndex = index;
    // Iterate through the string, character by character
    // then assign the character to the text field,
    // starting from the field the action was initiated from.
    // for eg. if the user pasted in the second text field, then this iteration will start assigning from there
    for (int i = 0; i < str.length; i++) {
      if (textFieldIndex >= widget.numberOfFields) break;
      // Extract the current character (digit)
      String digit = str.substring(i, i + 1);
      // Update the text in the corresponding text controller
      _textControllers[textFieldIndex]!.text = digit;

      // Set the text value explicitly for the controller
      _textControllers[textFieldIndex]!.value = TextEditingValue(text: digit);

      // Update the verification code array with the digit
      _verificationCode[textFieldIndex] = digit;

      _onDigitEntered(digit, textFieldIndex);
      textFieldIndex += 1;
      setState(() {});
    }
  }
}
