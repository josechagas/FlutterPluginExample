import Flutter
import UIKit

public class SwiftLearningflutterpluginPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        //Registra uma view nativa para o Flutter usar
        registrar.register(FlutterTextViewFactory(registrar: registrar),withId: FlutterTextView.viewType)
        
        //Registra uma view nativa que foi criada por terceiros.
        registrar.register(IndicatorSeekbarFactory(),withId: FlutterIndicatorSeekbar.viewType)
        
        //Registra uma classe para responder a um canal, mais detalhes olhar classe.
        PlatformInfo.register(with: registrar)
    }
}
