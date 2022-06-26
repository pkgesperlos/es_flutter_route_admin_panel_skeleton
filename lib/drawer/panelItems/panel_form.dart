import 'package:es_flutter_component/es_form/es_dropp_down_button/es_drop_down_button.dart';
import 'package:checklist_admin_panel/drawer/panelItems/container_items.dart';
import 'package:es_flutter_component/constants.dart';
import 'package:es_flutter_component/es_form/es_animated_checkbox.dart';
import 'package:es_flutter_component/es_form/es_checkbox.dart';
import 'package:es_flutter_component/es_form/es_checkbox_vallidation.dart';
import 'package:es_flutter_component/es_form/es_date_time_picker/es_android_time_picker.dart';
import 'package:es_flutter_component/es_form/es_date_time_picker/es_cupertino_12h_time_picker.dart';
import 'package:es_flutter_component/es_form/es_date_time_picker/es_cupertino_time_picker.dart';
import 'package:es_flutter_component/es_form/es_date_time_picker/es_english_date_picker.dart';
import 'package:es_flutter_component/es_form/es_date_time_picker/es_persian_date_picker.dart';
import 'package:es_flutter_component/es_form/es_file_picker/es_file_picker.dart';

import 'package:es_flutter_component/es_form/es_ordinary_slider.dart';
import 'package:es_flutter_component/es_form/es_phone_number_field.dart';
import 'package:es_flutter_component/es_form/es_price_field.dart';
import 'package:es_flutter_component/es_form/es_radio_button.dart';
import 'package:es_flutter_component/es_form/es_ranged_slider.dart';
import 'package:es_flutter_component/es_form/es_rating_bar.dart';
import 'package:es_flutter_component/es_form/es_shaba_number_field.dart';
import 'package:es_flutter_component/es_form/es_text_area.dart';
import 'package:es_flutter_component/es_form/es_text_field.dart';
import 'package:es_flutter_component/es_form/es_toggle_button.dart';
import 'package:es_flutter_component/es_text/es_ordinary_text.dart';
import 'package:checklist_admin_panel/images/panelConstants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../images/panelConstants.dart';

class PanelForm extends StatelessWidget {
  const PanelForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = [
      ContainerItems(
          widget:EsTextField(
            type: AppLocalizations.of(context)!.textFieldType,
            hint: AppLocalizations.of(context)!.textFieldHint,
          ),
          title:AppLocalizations.of(context)!.textField,
          information:"It is a text field located in: \n es_flutter_component>lib>es_form>es_text_field.dart \n and is used as: \n "
              """ EsTextField(
            type: AppLocalizations.of(context)!.textFieldType,
            hint: AppLocalizations.of(context)!.textFieldHint,)"""
      ),
      ContainerItems(widget:EsPhoneNumberField(),
          title:AppLocalizations.of(context)!.phoneNumbertextField,
          information:"It is a phone number field located in: \n es_flutter_component>lib>es_form>es_phone_number_field.dart \n and is used as: \n "
              """ EsPhoneNumberField()"""
      ),
      ContainerItems(widget:EsShabaNumberField(),
          title:AppLocalizations.of(context)!.shabaNumbertextField,
          information:"It is a shaba number field located in: \n es_flutter_component>lib>es_form>es_shaba_number_field.dart \n and is used as: \n "
              """ EsShabaNumberField()"""
      ),
      ContainerItems(widget:EsPriceField(),title: AppLocalizations.of(context)!.priceTextField,
          information:"It is a price field located in: \n es_flutter_component>lib>es_form>es_price_field.dart \n and is used as: \n "
              """ EsPriceField()"""),
      ContainerItems(
          widget:EsPersianDatePicker(
            title: AppLocalizations.of(context)!.datePickerTitle,
          ),
          title:AppLocalizations.of(context)!.datePickerfa,
          information:"It is a jalali date picker located in: \n es_flutter_component>lib>es_form>es_date_time_picker>es_persian_date_picker.dart \n and is used as: \n "
              """ EsPersianDatePicker()"""),
      ContainerItems(
          widget:EsEnglishDatePicker(
            title: AppLocalizations.of(context)!.datePickerTitle,
          ),
          title:AppLocalizations.of(context)!.datePickeren,
          information:"It is a Gregorian date picker located in: \n es_flutter_component>lib>es_form>es_date_time_picker>es_English_date_picker.dart \n and is used as: \n "
              """ EsEnglishDatePicker()"""
      ),
      ContainerItems(
          widget:EsAndroidTimePicker(
            title: AppLocalizations.of(context)!.androidTimePickerTitle,
          ),
          title:AppLocalizations.of(context)!.timePickerHM,
          information:"It is a time picker(H/M)  located in: \n es_flutter_component>lib>es_form>es_date_time_picker>es_android_time_picker.dart \n and is used as: \n "
              """ EsAndroidTimePicker(
            title: AppLocalizations.of(context)!.androidTimePickerTitle,)"""
      ),
      ContainerItems(
          widget:EsCupertinoTimePicker(
            title: AppLocalizations.of(context)!.cupertinoTimePickerTitle,
          ),
          title:AppLocalizations.of(context)!.timePickerHMS,
          information:"It is a time picker(H/M/S) located in: \n es_flutter_component>lib>es_form>es_date_time_picker>es_cupertino_12h_time_picker.dart \n and is used as: \n "
              """ EsCupertinoTimePicker(
            title: AppLocalizations.of(context)!.cupertinoTimePickerTitle,)"""
      ),
      ContainerItems(widget:EsOrdinarySlider(),
          title:AppLocalizations.of(context)!.ordinarySlider,
          information:"It is an ordinary slider located in: \n es_flutter_component>lib>es_form>es_ordinary_slider.dart \n and is used as: \n "
              """EsOrdinarySlider()"""
      ),
      ContainerItems(widget:EsRengedSlider(), title:AppLocalizations.of(context)!.rangedSlider,
          information:"It is a ranged slider located in: \n es_flutter_component>lib>es_form>es_ranged_slider.dart \n and is used as: \n "
              """EsRengedSlider()"""
      ),
      ContainerItems(widget:EsRadioButton(), title:AppLocalizations.of(context)!.radioButons,
          information:"It is a radio button located in: \n es_flutter_component>lib>es_form>es_radio_button.dart \n and is used as: \n "
              """EsRadioButton()"""
      ),
      ContainerItems(
          widget:EsTextArea(
            type: AppLocalizations.of(context)!.textAreaType,
            hint: AppLocalizations.of(context)!.textAreaHint,
          ),
          title:AppLocalizations.of(context)!.textArea,
          information:"It is a text area located in: \n es_flutter_component>lib>es_form>es_text_area.dart \n and is used as: \n "
              """EsTextArea(
            type: AppLocalizations.of(context)!.textAreaType,
            hint: AppLocalizations.of(context)!.textAreaHint,)"""
      ),
      ContainerItems(widget:EsRatingBar(), title:AppLocalizations.of(context)!.starRateBar,
          information:"It is a rating bar located in: \n es_flutter_component>lib>es_form>es_rating_bar.dart \n and is used as: \n "
              """EsRatingBar()"""
      ),
      ContainerItems(
        widget:IntrinsicWidth(
            child: EsCheckBox(
              title: EsOrdinaryText(
                data: AppLocalizations.of(context)!.checkBoxTitle,
              ),
              onSaved: (bool) {},
              validator: (bool) {},
            ),
          ),
        title:AppLocalizations.of(context)!.ordinaryCheckBox,
        information:"It is a ordinary check box located in: \n es_flutter_component>lib>es_form>es_checkbox.dart \n and is used as: \n "
              """EsCheckBox(
              title: EsOrdinaryText(
                data: AppLocalizations.of(context)!.checkBoxTitle,
              ),
              onSaved: (bool) {},
              validator: (bool) {},)""",
      ),
      ContainerItems(
          widget:IntrinsicWidth(
            child: EsCheckBoxvalidation(
              title: AppLocalizations.of(context)!.checkBoxWithValidator,
              errorText: AppLocalizations.of(context)!.checkBoxErrorText,
              buttonText: AppLocalizations.of(context)!.checkBoxButtonText,
            ),
          ),
          title:AppLocalizations.of(context)!.validationCheckBox,
          information:"It is a check box with validation located in: \n es_flutter_component>lib>es_form>es_checkbox_validation.dart \n and is used as: \n "
              """EsCheckBoxvalidation(
              title: AppLocalizations.of(context)!.checkBoxWithValidator,
              errorText: AppLocalizations.of(context)!.checkBoxErrorText,
              buttonText: AppLocalizations.of(context)!.checkBoxButtonText,
            )"""
      ),
      ContainerItems(
          widget:IntrinsicWidth(
            child: EsAnimatedCheckBox(
                title: AppLocalizations.of(context)!.animatedCheckBoxTitle),
          ),
          title:AppLocalizations.of(context)!.animationCheckBox,
          information:"It is an animated check box located in: \n es_flutter_component>lib>es_form>es_animated_checkbox.dart \n and is used as: \n "
              """EsAnimatedCheckBox(
                title: AppLocalizations.of(context)!.animatedCheckBoxTitle)"""
      ),
      ContainerItems(
          widget:EsDropDownButton(
            items: [
              // "گزینه1","گزینه2","گزینه3",
              AppLocalizations.of(context)!.dropDown1,
              AppLocalizations.of(context)!.dropDown2,
              AppLocalizations.of(context)!.dropDown3,
            ],
            onTapItems: [() {}, () {}, () {}],
          ),
          title:AppLocalizations.of(context)!.dropDownButton,
          information:"It is dropp down button located in: \n es_flutter_component>lib>es_form>es_drop_down_button.dart \n and is used as: \n "
              """EsDropDownButton(
            items: [
              AppLocalizations.of(context)!.dropDown1,
              AppLocalizations.of(context)!.dropDown2,
              AppLocalizations.of(context)!.dropDown3,
            ],
            onTapItems: [() {}, () {}, () {}],
          )"""
      ),
      ContainerItems(widget:ESToggleButton(), title:AppLocalizations.of(context)!.toggleButton,
          information:"It is toggle button located in: \n es_flutter_component>lib>es_form>es_toggle_button.dart \n and is used as: \n "
              """ESToggleButton()"""
      ),
      ContainerItems(
          widget:Center(
              child: EsFilePicker(
            openText: AppLocalizations.of(context)!.openText,
            pickText: AppLocalizations.of(context)!.pickText,
            clearText: AppLocalizations.of(context)!.clearText,
          )),
          title:AppLocalizations.of(context)!.filePicker,
          information:"It is file picker located in: \n es_flutter_component>lib>es_form>es_file picker.dart \n and is used as: \n "
              """EsFilePicker(
            openText: AppLocalizations.of(context)!.openText,
            pickText: AppLocalizations.of(context)!.pickText,
            clearText: AppLocalizations.of(context)!.clearText,
          )"""
      ),
    ];
    return Material(
        color: PanelConstants.backGround,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: PanelConstants.paddingDimension),
                margin: EdgeInsets.all(PanelConstants.paddingDimension * 2),

                width: double.maxFinite,
                ////////////////////////
                child: EsOrdinaryText(
                  data: AppLocalizations.of(context)!.formDescription,
                ),
                decoration: BoxDecoration(
                    color: PanelConstants.forGround,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.paddingDimension))),
              ),
              BootstrapContainer(
                  fluid: true,
                  padding: EdgeInsets.all(PanelConstants.paddingDimension),
                  decoration: BoxDecoration(
                    color: PanelConstants.backGround,
                  ),
                  children: List.generate(
                      list.length, (index) => _boxShow(list[index])))
            ],
          ),
        ));
  }

  Widget _boxShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-6',
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: PanelConstants.paddingDimension,
            vertical: PanelConstants.paddingDimension,
          ),
          margin: EdgeInsets.all(PanelConstants.paddingDimension),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(PanelConstants.paddingDimension * 2)),
              color: PanelConstants.forGround),
          child: widget,
        ));
  }
}
