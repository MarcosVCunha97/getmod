import 'dart:io';

void main(List<String> args) {

  assert(args.length == 1, 'Digite um comando válido');
  String cmd = args[0];

  Directory current = Directory.current;
  List<FileSystemEntity> files = current.listSync(followLinks: false);

  assert(files.any((element) => element.path.contains('pubspec.yaml')), 'No pubspec.yaml found in current directory');
  assert(files.any((element) => element.path.contains('lib')), 'No lib folder found in current directory');

  if(cmd == 'create_page'){
    assert(args.length == 3, 'Formato válido do comando: main create_page <nome do modulo> <nome da página>');
    String module = args[1];
    String pageName = args[2];
    String pageNameCamel = toCamelCase(pageName);
    String pageNameSnake = toSnakeCase(pageName);
    
    
    // Deve ser um projeto do flutter
    Directory moduleDirectory = Directory('lib/app/modules/$module');

    if(!moduleDirectory.existsSync()){
      // cria diretorios module/pages, modules/controllers e modules/bindings
      moduleDirectory.createSync(recursive: true);
      Directory('lib/app/modules/$module/pages').createSync(recursive: true);
      Directory('lib/app/modules/$module/controllers').createSync(recursive: true);
      Directory('lib/app/modules/$module/bindings').createSync(recursive: true);
    }

    String bindingTemplate = File('templates/binding_template.txt').readAsStringSync();
    String controllerTemplate = File('templates/controller_template.txt').readAsStringSync();
    String pageTemplate = File('templates/page_template.txt').readAsStringSync();
    bindingTemplate = bindingTemplate.replaceAll('[PAGE_NAME]', pageNameCamel);
    controllerTemplate = controllerTemplate.replaceAll('[PAGE_NAME]', pageNameCamel);
    pageTemplate = pageTemplate.replaceAll('[PAGE_NAME]', pageNameCamel);
    bindingTemplate = bindingTemplate.replaceAll('[PAGE_NAME_SNAKE]', pageNameSnake);
    controllerTemplate = controllerTemplate.replaceAll('[PAGE_NAME_SNAKE]', pageNameSnake);
    pageTemplate = pageTemplate.replaceAll('[PAGE_NAME_SNAKE]', pageNameSnake);

    File('lib/app/modules/$module/bindings/${pageNameSnake}_binding.dart').writeAsStringSync(bindingTemplate);
    File('lib/app/modules/$module/controllers/${pageNameSnake}_controller.dart').writeAsStringSync(controllerTemplate);
    File('lib/app/modules/$module/pages/${pageNameSnake}_page.dart').writeAsStringSync(pageTemplate);
  }

}

bool isCamelCase(String s) {
  return s != s.toLowerCase() && s != s.toUpperCase() && int.tryParse(s[0]) == null;
}

// converte snake_case para camelCase
String toCamelCase(String s) {
  if(!isCamelCase(s)){
    return s.split('_').map((e) => e[0].toUpperCase() + e.substring(1)).join();
  }else{
    return s;
  }
}

// converte camelCase para snake_case
String toSnakeCase(String s) {
  if(isCamelCase(s)){
    return s.splitMapJoin(
      RegExp('[A-Z]'),
      onMatch: (m) => '_${m.group(0)?.toLowerCase()}',
      onNonMatch: (n) => n,
    );
  }else{
    return s;
  }  
}