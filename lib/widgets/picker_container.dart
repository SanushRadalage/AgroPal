import 'dart:io';

import 'package:agropal/theme/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget pickerContainer(double maxHeight, double maxWight, File? file) {
  return DottedBorder(
    strokeCap: StrokeCap.butt,
    color: AppColors.primary,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              child: file != null
                  ? Image.file(
                      file,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(
                      width: maxWight * 0.2,
                      height: maxHeight * 0.2,
                      child: Icon(
                        Icons.photo_camera,
                        color: AppColors.primary,
                        size: 48.0,
                      ),
                    ),
            ),
          )
        ],
      ),
    ),
  );
}
