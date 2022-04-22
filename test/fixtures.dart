import 'dart:convert';
import 'dart:io';

fixture(String fileName) => jsonDecode(File('test/fixtures/$fileName').readAsStringSync());
