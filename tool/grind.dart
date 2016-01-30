import 'package:grinder/grinder.dart';
import 'dart:io';

main(args) => grind(args);

@DefaultTask()
@Depends(js)
build() {}

@Task('Builds main.js')
js() => Dart2js.compile(new File('scripts/_src/main.dart'), outFile: new File('scripts/main.js'), minify: true);
