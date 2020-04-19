# otp_text_field

![](https://github.com/david-legend/otp_textfield/workflows/Flutter%20Build%20Test%20CI/badge.svg?branch=master)
[![pub package](https://img.shields.io/pub/v/otp_textfield.svg)](https://pub.dartlang.org/packages/otp_textfield)
![GitHub](https://img.shields.io/github/license/david-legend/otp_textfield)
![GitHub top language](https://img.shields.io/github/languages/top/david-legend/otp_textfield)

# otp_text_field

OtpTextField is a TextField widget to help display different style pin. It supports all the platforms [flutter](https://github.com/flutter/flutter) supports.

## Feature 👇👇
* allows you to customize the shape of textField in any way you want
* built-in 2 commonly used pin styles of shape
* obscure support
* input decoration support
* support all the textField properties support
* Flutter web support


## Installing 🔧
Install the latest version from [pub](https://pub.dartlang.org/packages/otp_textfield).

## Usage 🚅

### Attributes
Customizable attributes for PinInputTextField
<table>
    <th>Attribute Name</th>
    <th>Example Value</th>
    <th>Description</th>
    <tr>
        <td>numberOfFields</td>
        <td>4</td>
        <td>The default is 4</td>
    </tr>
    <tr>
        <td>fieldWidth</td>
        <td>40</td>
        <td>allows to change the width of the textField</td>
    </tr>
    <tr>
        <td>showFieldAsBox</td>
        <td>true</td>
        <td>changes the default decoration of the textFields to a box with borderRadius of 4.0</td>
    </tr>
    <tr>
            <td>hasCustomInputDecoration</td>
            <td>true</td>
            <td>set this to true if you want to pass your own decoration</td>
    </tr>
     <tr>
            <td>decoration</td>
            <td>InputDecoration</td>
            <td>set hasCustomInputDecoration to true and pass your own input decoration the way you see fit</td>
    </tr>
     <tr>
            <td>filled</td>
            <td>false</td>
            <td>set to true if you want to pass a fillColor</td>
     </tr>
     <tr>
            <td>fillColor</td>
            <td>Colors.red</td>
            <td>pass fillColor and set filled to true</td>
    </tr>
    <tr>
        <td>borderRadius</td>
        <td>BorderRadius.all(Radius.circular(4.0))</td>
        <td>pass BorderRadius to customise textField when showFieldAsBox is set to true</td>
    </tr>
    <tr>
        <td>margin</td>
        <td>EdgeInsets.only(right: 8.0)</td>
        <td>customize the margin between each textField</td>
    </tr>
    <tr>
        <td>textStyle</td>
        <td>TextStyle(fontSize: 20, color: Colors.green);</td>
        <td>Add custom textStyle</td>
    </tr>
    <tr>
            <td>borderWidth</td>
            <td>2.0</td>
            <td>Default value is 2.0, allows you to customize the width of the border</td>
    </tr>
    <tr>
        <td>cursorColor</td>
        <td>Colors.blue</td>
        <td>Change color of textFields cursor. Defaults to [ThemeData.cursorColor] 
        or [CupertinoTheme.primaryColor] depending on [ThemeData.platform]. 
        </td>
    </tr>
    <tr>
        <td>cursorColor</td>
        <td>Colors.blue</td>
        <td>Change color of textFields cursor. Defaults to [ThemeData.cursorColor] 
        or [CupertinoTheme.primaryColor] depending on [ThemeData.platform]. 
        </td>
    </tr>
    <tr>
        <td>mainAxisAlignment</td>
        <td>MainAxisAlignment.center</td>
        <td>Defaults to MainAxisAlignment.center</td>
    </tr>
     <tr>
        <td>crossAxisAlignment</td>
        <td>CrossAxisAlignment.center</td>
        <td>Defaults to CrossAxisAlignment.center</td>
    </tr>
    <tr>
        <td>onSubmit</td>
        <td>(String pin){}</td>
        <td>The callback will execute when user is done inputting the verification code.</td>
    </tr>
    <tr>
        <td>keyboardType</td>
        <td>TextInputType.number</td>
        <td>Just like TextField's keyboardType, the default is TextInputType.phone</td>
    </tr>
    <tr>
        <td>autoFocus</td>
        <td>false</td>
        <td>Same as TextField's autoFocus, the default is false</td>
    </tr>
    <tr>
        <td>enabled</td>
        <td>true</td>
        <td>Same as TextField's enabled, the default is true</td>
    </tr>
    <tr>
        <td>obscureText</td>
        <td>false</td>
        <td>Defaults to false</td>
    </tr>
    <tr>
        <td>onCodeChanged</td>
        <td>(String code){}</td>
        <td>Same as TextField's onChanged</td>
    </tr>
</table>