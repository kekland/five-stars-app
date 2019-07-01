import 'package:five_stars/design/boolean_select_widget.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceSelectWidget extends StatelessWidget {
  final double price;
  final Function(double) onSelect;

  const PriceSelectWidget({Key key, this.price, this.onSelect})
      : super(key: key);

  onTap(BuildContext context) async {
    TextEditingController controller = TextEditingController(
      text: (price != null) ? price.round().toString() : '',
    );

    bool checked = price == null;

    double returnValue = await showModernDialog<double>(
      context: context,
      title: 'Выберите значение',
      body: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              BoolSelectWidget(
                value: checked,
                onSelected: (v) => setState(() => checked = v),
                title: 'Договорная цена',
                color: Colors.indigo,
                padLeft: false,
              ),
              SizedBox(height: 8.0),
              ModernTextField(
                hintText: 'Цена',
                suffixText: 'тг.',
                icon: FontAwesomeIcons.dollarSign,
                controller: controller,
                error: (double.tryParse(controller.text) != null &&
                        double.tryParse(controller.text) > 0.0) || checked
                    ? null
                    : 'Неправильная цена',
                onChanged: (_) => setState(() => {}),
                enabled: !checked,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.of(context).pop(-1.0)),
                  FlatButton(
                    child: Text('Выбрать'),
                    textColor: Colors.indigo,
                    onPressed: (double.tryParse(controller.text) != null &&
                        double.tryParse(controller.text) > 0.0) || checked
                    ? () => Navigator.pop(context, double.tryParse(controller.text))
                    : null,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
    
    if (returnValue != -1.0) {
      onSelect(returnValue);
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
            icon: FontAwesomeIcons.dollarSign,
            iconColor: ModernTextTheme.captionIconColor,
            value: price != null ? '${price.round().toString()}' : 'Договорная',
            unit: (price != null)? 'тг.' : '',
            title: 'Цена',
          ),
        ),
      ),
    );
  }
}
