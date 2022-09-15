import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileNotifier extends ChangeNotifier {
  final List<File> _images = [];
  File? _fileOne;
  File? _fileTwo;
  File? _fileThree;
  File? _fileFour;

  List<File> get images => _images;
  File? get fileOne => _fileOne;
  File? get fileTwo => _fileTwo;
  File? get fileThree => _fileThree;
  File? get fileFour => _fileFour;

  updateFiles({File? fileOne, File? fileTwo, File? fileThree, File? fileFour}) {
    if (fileOne != null) _fileOne = fileOne;
    if (fileTwo != null) _fileTwo = fileTwo;
    if (fileThree != null) _fileThree = fileThree;
    if (fileFour != null) _fileFour = fileFour;
    notifyListeners();
  }

  resetFiles() {
    _fileOne = null;
    _fileTwo = null;
    _fileThree = null;
    _fileFour = null;
    _images.clear();
    notifyListeners();
  }

  addImages() {
    if (_fileOne != null) {
      _images.add(_fileOne!);
    }

    if (_fileTwo != null) {
      _images.add(_fileTwo!);
    }

    if (_fileThree != null) {
      _images.add(_fileThree!);
    }

    if (_fileFour != null) {
      _images.add(_fileFour!);
    }
    notifyListeners();
  }
}

final fileProvider = ChangeNotifierProvider<FileNotifier>((ref) {
  return FileNotifier();
});
