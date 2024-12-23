## [1.4.0] - 2024/12/23

* Fixed issue where KeyboardListener would run twice and cause cursor to skip a text field
* Fixed issue where auto-filling would only enter a value in the first input field
* Fixed issue where pasting the OTP would only advance the focus to the second field, and would not submit the form


## [1.3.0] - 2024/12/22

* Fixed a bug where backspace did not properly shift focus to the previous input field.


## [1.2.0] - 2024/03/14

* Keyboard Listener: Allow pasting OTP codes directly for a more convenient and efficient experience

## [1.1.2+1] - 2024/03/14

* exposed content padding 

## [1.1.2] - 2024/03/14

* exposed height and alignment to api to allow setting the height and aligning the text fields

## [1.1.1] - 2022/09/02

* Added functionality to jump to previous Text field after deleting a number

## [1.1.0] - 2022/08/02

* added clearText to allow users to clear text
* exposed textFields list of controllers - helps in the manipulation of text

## [0.0.1] - 2020/04/19 

* added customizable input decoration
* added customizable borderRadius
* added customizable borderColor and borderWidth for focused and disabled border
* added onChanged to observe the text changed
* added OnSubmit to handle submits, validation and navigation after text changed

