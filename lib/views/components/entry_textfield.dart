import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gratitude_app/business_logic/BLoC/bloc/value_changed_bloc.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';

class EntryTextField extends StatelessWidget {
  final ValueChangedBloc<bool> _entryTextValidationBloc;
  final TextEditingController _entryController;

  const EntryTextField(this._entryTextValidationBloc, this._entryController,
      {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      cursorColor: Theme.of(context).primaryColor,
      autofocus: true,
      onChanged: (value) {
        if (value.isEmpty)
          _entryTextValidationBloc.changeValue(false);
        else if (value.length == 1) _entryTextValidationBloc.changeValue(true);
      },
      controller: _entryController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: const Color(0xFFA8DADC)),
            borderRadius: BorderRadius.circular(25)),
        labelText: SharedPrefService.getInstance().phraseChosen,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: const Color(0xFFA8DADC)),
            borderRadius: BorderRadius.circular(25)),
      ),
      style: Theme.of(context).textTheme.subtitle2,
      maxLines: 4,
    );
  }
}
