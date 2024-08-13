import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayaar/core/components/colors.dart';

Widget defaultButton({
  Color color = AppColors.prussianBlue,
  Color textColor = AppColors.ivory,
  double height = 52,
  double width = double.infinity,
  bool isUpperCase = false,
  double radius = 13.0,
  required VoidCallback function,
  required BuildContext context,
  required String text,
}) =>
    Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color:textColor, fontSize: 16),
          ),
        ));

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  required BuildContext context,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
        ));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        validator: (value) {
          return validate(value);
        },
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        obscureText: isPassword,
        // onFieldSubmitted: (_) {
        //   onSubmit();
        // },
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          prefixIcon: Icon(
            prefix,
            color: AppColors.alabster,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Set the desired border radius value
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

void navigateTo(context, widget) => Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });
