import 'package:flutter/material.dart';
import 'package:gratitude_app/business_logic/models/entry.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';

import 'utils/gratitude_app_icons.dart';

typedef void EditModalFunctionCallBack(Entry element, int index);

class EntryListItem extends StatelessWidget {
  final EditModalFunctionCallBack _editCallback;
  final int _entriesLength;
  final int _index;
  final Entry _element;
  const EntryListItem(
      this._editCallback, this._entriesLength, this._index, this._element,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _index == _entriesLength - 1
          ? EdgeInsets.only(bottom: 69.0, left: 10, right: 0)
          : EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(
                GratitudeAppIcons.pencil,
                size: 20,
              ),
              splashRadius: 18,
              onPressed: () {
                _editCallback(_element, _index);
              }),
          Flexible(
            child: Card(
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              elevation: 6,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (context) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: 500,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF).withOpacity(0.05),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: SingleChildScrollView(
                                child: Text(
                                  "${SharedPrefService.getInstance().phraseChosen} ${_element.entryText}",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${SharedPrefService.getInstance().phraseChosen} ",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.bold)),
                      Flexible(
                        child: Text(_element.entryText,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
