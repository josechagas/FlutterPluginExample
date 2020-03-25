import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//https://medium.com/flutter-community/flutter-platformview-how-to-create-flutter-widgets-from-native-views-366e378115b6
//https://medium.com/rohit-nisal/use-native-ui-in-flutter-application-97d73f5beada
//https://flutter.dev/docs/development/packages-and-plugins/developing-packages
//https://api.flutter.dev/objcdoc/Protocols/FlutterPlatformViewFactory.html
//https://medium.com/rohit-nisal/use-native-ui-in-flutter-application-97d73f5beada

/**
 * OBS:
 * Ao que tudo indica não existe uma real necessidade de criar um canal
 * de comunicacao para cada view nativa criada, pois quando alteramos as
 * informacoes o Widget que encapsula esse componente sera responsavel por
 * fazer o Build novamente da view entao para que criar um canal para 'set' de dados.
 *
 * Pela minha analise o canal se torna necessário quando a view por algum motivo
 * gera alguma informação e voceê precisa recuperar esse dado, com o canal para
 * instancia 'x' da view voceê é capaz de pedir essas informações geradas.
 *
 * Por questão de aprendizado essa view terá tudo implementado. É IMPORTANTE não
 * esquecer de investigar as necessidades antes de ir criando canal para toda view nativa.
 * */

typedef void TextViewCreatedCallback(TextViewController controller);

class TextView extends StatefulWidget {
  static final viewType = 'learning_flutter_plugin/text_view';

  const TextView({
    Key key,
    this.onTextViewCreated,
    this.text,
  }) : super(key: key);

  final TextViewCreatedCallback onTextViewCreated;
  final String text;

  @override
  State<StatefulWidget> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    final arguments = {"text": widget.text};

    if (Platform.isAndroid) {
      return AndroidView(
        viewType: TextView.viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: arguments,
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: TextView.viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: arguments,
        creationParamsCodec: StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onTextViewCreated == null) {
      return;
    }
    widget.onTextViewCreated(new TextViewController._(id));
  }
}

class TextViewController {
  TextViewController._(int id)
      : _channel = new MethodChannel('${TextView.viewType}_$id');

  final MethodChannel _channel;

  Future<void> setText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
}
