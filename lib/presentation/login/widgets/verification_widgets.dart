import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/country_code_validation.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/loading_circle.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/colors_res.dart';

Widget elevatedButtonWidget(
    {required String text,
    required String logo,
    required void Function()? onPressed,
    required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    height: 48,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorResources.colorwhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logo),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget logoWidget({required String image, required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: ColorResources.colorwhite,
          borderRadius: BorderRadius.circular(100)),
      child: Image.asset(image),
    ),
  );
}

Widget buttonWidget({
  required BuildContext context,
  required String text,
  required Color? backgroundColor,
  required Color? txtColor,
  required void Function()? onPressed,
  bool isLoading = false,
}) {
  return SizedBox(
    height: 45,
    width: MediaQuery.sizeOf(context).width,
    child: isLoading
        ? LoadingCircle()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: backgroundColor,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: txtColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
  );
}

Widget textFieldWidget({
  required TextEditingController? controller,
  required String? labelText,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    height: 54,
    child: TextFormField(
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email address';
            }

            final emailRegex = RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
            );
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.plusJakartaSans(
        color: ColorResources.colorBlack,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.plusJakartaSans(
          color: ColorResources.colorgrey600,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        fillColor: ColorResources.colorwhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorResources.colorBlack),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorResources.colorgrey300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorResources.colorgrey200),
        ),
      ),
    ),
  );
}

Widget passwordTextFieldWidget({
  required TextEditingController? controller,
  required String? labelText,
  String? Function(String?)? validator,
}) {
  bool obscureText = true;
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        height: 54,
        child: TextFormField(
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorBlack,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorResources.colorgrey600,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            fillColor: ColorResources.colorwhite,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorResources.colorBlack),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorResources.colorgrey300),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorResources.colorgrey200),
            ),
          ),
        ),
      );
    },
  );
}

Widget phoneTextFieldWidget({
  required TextEditingController? controller,
  required BuildContext context,
  void Function(CountryCode)? onChanged,
  String? initialSelection,
  String? Function(String?)? validator,
}) {
  String currentCountryCode = initialSelection ?? 'IN';

  return StatefulBuilder(
    builder: (context, setState) {
      return Row(
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: ColorResources.colorgrey300),
              color: ColorResources.colorwhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CountryCodePicker(
              padding: const EdgeInsets.all(0),
              onChanged: (CountryCode code) {
                setState(() {
                  currentCountryCode = code.code ?? 'IN';
                });
                if (onChanged != null) {
                  onChanged(code);
                }
              },
              initialSelection: initialSelection,
              favorite: const ['+91', '+971'],
              textStyle: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorBlack,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              showFlag: false,
              alignLeft: false,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextFormField(
                maxLength: CountryPhoneValidation.getPhoneLengthByCountry(
                    currentCountryCode)['maxLength'],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }

                      final phoneData =
                          CountryPhoneValidation.getPhoneLengthByCountry(
                              currentCountryCode);
                      final minLength = phoneData['minLength'];
                      final maxLength = phoneData['maxLength'];

                      if (value.length < minLength) {
                        return 'Phone number must be at least $minLength digits';
                      }
                      if (value.length > maxLength) {
                        return 'Phone number cannot exceed $maxLength digits';
                      }

                      return null;
                    },
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.colorBlack),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.colorgrey300),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.colorgrey200),
                  ),
                  fillColor: ColorResources.colorwhite,
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  filled: true,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget datePickerWidget({
  required TextEditingController? controller,
  required String? labelText,
  required BuildContext context,
  required void Function()? onTap,
  bool showAsterisk = false, // Add this parameter
}) {
  return SizedBox(
    height: 54,
    child: TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: GoogleFonts.plusJakartaSans(
        color: ColorResources.colorBlack,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.calendar_today_outlined,
          size: 18,
          color: ColorResources.colorgrey500,
        ),
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            children: [
              if (showAsterisk)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        fillColor: ColorResources.colorwhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: showAsterisk ? Colors.red : ColorResources.colorBlack,
            width: showAsterisk ? 1.5 : 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: showAsterisk ? Colors.red : ColorResources.colorgrey300,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorResources.colorgrey200),
        ),
      ),
    ),
  );
}

Future<void> selectDate(
    BuildContext context, TextEditingController? controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2014, 12, 31),
    firstDate: DateTime(1900),
    lastDate: DateTime(2014, 12, 31),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: ColorResources.colorBlack,
          colorScheme: ColorScheme.light(primary: ColorResources.colorBlack),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          datePickerTheme: DatePickerThemeData(
            headerForegroundColor: ColorResources.colorwhite,
            headerBackgroundColor: ColorResources.colorgrey700,
            dayBackgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorResources.colorgrey700;
                }
                return ColorResources.colorwhite;
              },
            ),
            dayForegroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorResources.colorwhite;
                }
                return ColorResources.colorBlack;
              },
            ),
            todayBackgroundColor: WidgetStateProperty.all(Colors.grey[300]),
            todayForegroundColor:
                WidgetStateProperty.all(ColorResources.colorBlack),
            yearForegroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorResources.colorwhite;
                }
                return ColorResources.colorBlack;
              },
            ),
            yearBackgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorResources.colorgrey700;
                }
                return ColorResources.colorwhite;
              },
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
    controller?.text = formattedDate;
  }
}

Widget dropdownWidget({
  required TextEditingController? controller,
  required String? labelText,
  bool showAsterisk = false, // Add this parameter
}) {
  return SizedBox(
    height: 54,
    child: DropdownButtonFormField<String>(
      alignment: Alignment.bottomCenter,
      value: controller != null && controller.text.isNotEmpty
          ? controller.text
          : null,
      onChanged: (String? value) {
        if (controller != null) {
          controller.text = value ?? '';
        }
      },
      items: <String?>['Male', 'Female'].map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value ?? 'Select Gender'),
        );
      }).toList(),
      style: GoogleFonts.plusJakartaSans(
        color: ColorResources.colorBlack,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            children: [
              if (showAsterisk)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        fillColor: ColorResources.colorwhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: showAsterisk ? Colors.red : ColorResources.colorBlack,
            width: showAsterisk ? 1.5 : 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: showAsterisk ? Colors.red : ColorResources.colorgrey300,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorResources.colorgrey200),
        ),
      ),
    ),
  );
}
