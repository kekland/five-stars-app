import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoundedNumberSelectWidget extends StatelessWidget {
  final Bounded value;
  final Function(Bounded) onSelected;
  final IconData icon;
  final String title;
  final String unit;

  const BoundedNumberSelectWidget(
      {Key key, this.value, this.onSelected, this.icon, this.title, this.unit})
      : super(key: key);

  void onTap(BuildContext context) async {
    TextEditingController lowerController = TextEditingController(
      text: (value?.lower != null) ? value.lower.toString() : '',
    );
    TextEditingController upperController = TextEditingController(
      text: (value?.upper != null) ? value.upper.toString() : '',
    );

    Bounded returnValue = await showModernDialog<Bounded>(
      context: context,
      title: 'Выберите границы',
      body: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ModernTextField(
                hintText: 'От',
                icon: Icons.chevron_right,
                keyboardType: TextInputType.number,
                suffixText: unit,
                controller: lowerController,
                error: (lowerController.text.isNotEmpty &&
                        double.tryParse(lowerController.text) == null)
                    ? 'Неправильное значение'
                    : null,
                onChanged: (_) => setState(() => {}),
              ),
              SizedBox(height: 8.0),
              ModernTextField(
                hintText: 'До',
                icon: Icons.chevron_left,
                keyboardType: TextInputType.number,
                suffixText: unit,
                controller: upperController,
                error: (upperController.text.isNotEmpty &&
                        double.tryParse(upperController.text) == null)
                    ? 'Неправильное значение'
                    : null,
                onChanged: (_) => setState(() => {}),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.of(context).pop()),
                  FlatButton(
                    child: Text('Выбрать'),
                    textColor: Colors.indigo,
                    onPressed: ((upperController.text.isEmpty ||
                                double.tryParse(upperController.text) !=
                                    null) &&
                            (lowerController.text.isEmpty ||
                                double.tryParse(lowerController.text) != null))
                        ? () => Navigator.of(context).pop(
                              Bounded(
                                lower: double.tryParse(lowerController.text),
                                upper: double.tryParse(upperController.text),
                              ),
                            )
                        : null,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
    if (returnValue != null) {
      onSelected(returnValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onTap(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TwoLineInformationWidgetExpanded(
            icon: icon,
            iconColor: ModernTextTheme.captionIconColor,
            value: value != null && (value.upper != null || value.lower != null)
                ? '${value.lower ?? 'не выбрано'} - ${value.upper ?? 'не выбрано'}'
                : 'Не выбрано',
            unit: '',
            title: title + ' ($unit)',
          ),
        ),
      ),
    );
  }
}
