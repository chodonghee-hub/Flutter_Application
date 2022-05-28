import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../extension.dart';
import '../model/event.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;

  const AddEventWidget({
    Key? key,
    this.onEventAdd,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  late DateTime _startDate;
  late DateTime _endDate;

  DateTime? _startTime;

  DateTime? _endTime;

  String _title = "";

  String _description = "";

  Color _color = Colors.blue;

  late FocusNode _titleNode;

  late FocusNode _descriptionNode;

  late FocusNode _dateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
    _dateNode = FocusNode();

    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _dateNode.dispose();

    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                labelText: "일정 제목",
              ),
              style: TextStyle(
                fontFamily: 'Noto_Serif_KR',
                color: AppColors.black,
                fontSize: 17.0,
              ),
              onSaved: (value) => _title = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "")
                  return "일정 제목을 추가하시오.";

                return null;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "시작 날짜",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "시작 날짜를 추가하시오.";

                      return null;
                    },
                    textStyle: TextStyle(
                      fontFamily: 'Noto_Serif_KR',
                      color: AppColors.black,
                      fontSize: 15.0,
                    ),
                    onSave: (date) => _startDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "종료 날짜",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "종료 날짜를 추가하시오.";

                      return null;
                    },
                    textStyle: TextStyle(
                      fontFamily: 'Noto_Serif_KR',
                      color: AppColors.black,
                      fontSize: 15.0,
                    ),
                    onSave: (date) => _endDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startTimeController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "시작 시간",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "시작 시간을 추가하시오.";

                      return null;
                    },
                    onSave: (date) => _startTime = date,
                    textStyle: TextStyle(
                      fontFamily: 'Noto_Serif_KR',
                      color: AppColors.black,
                      fontSize: 15.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endTimeController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "종료 시간",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "종료 시간을 추가하시오.";

                      return null;
                    },
                    onSave: (date) => _endTime = date,
                    textStyle: TextStyle(
                      fontFamily: 'Noto_Serif_KR',
                      color: AppColors.black,
                      fontSize: 15.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              focusNode: _descriptionNode,
              style: TextStyle(
                fontFamily: 'Noto_Serif_KR',
                color: AppColors.black,
                fontSize: 17.0,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              selectionControls: MaterialTextSelectionControls(),
              minLines: 1,
              maxLines: 10,
              maxLength: 1000,
              validator: (value) {
                if (value == null || value.trim() == "")
                  return "세부사항을 추가하시오.";

                return null;
              },
              onSaved: (value) => _description = value?.trim() ?? "",
              decoration: AppConstants.inputDecoration.copyWith(
                hintText: "세부 사항",
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  "색 설정: ",
                  style: TextStyle(
                    fontFamily: 'Noto_Serif_KR',
                    color: AppColors.black,
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: _displayColorPicker,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: _color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              onTap: _createEvent,
              title: "완료",
            ),
          ],
        ),
      ),
    );
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData<Event>(
      date: _startDate,
      color: _color,
      endTime: _endTime,
      startTime: _startTime,
      description: _description,
      endDate: _endDate,
      title: _title,
      event: Event(
        title: _title,
      ),
    );

    widget.onEventAdd?.call(event);
    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
    _endTimeController.text = "";
    _startTimeController.text = "";
  }

  void _displayColorPicker() {
    var color = _color;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (_) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: AppColors.bluishGrey,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(20.0),
        children: [
          Text(
            "색 설정",
            style: TextStyle(
              fontFamily: 'Noto_Serif_KR',
              color: AppColors.black,
              fontSize: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 1.0,
            color: AppColors.bluishGrey,
          ),
          ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            pickerColor: _color,
            onColorChanged: (c) {
              color = c;
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: CustomButton(
                title: "완료",
                onTap: () {
                  if (mounted)
                    setState(() {
                      _color = color;
                    });
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
