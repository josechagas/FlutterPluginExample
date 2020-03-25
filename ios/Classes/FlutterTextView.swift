import Flutter
import UIKit

/*
* O 'FlutterPlatformViewFactory' so precisa de uma referencia para 'FlutterPluginRegistrar' se
* a 'View' que ele vai criar precisa ter um canal para comunicação. ALERTA: pode ser que ter essa referencia cause memory leaks.
* */
public class FlutterTextViewFactory : NSObject, FlutterPlatformViewFactory {
    private var registrar:FlutterPluginRegistrar?
    
    init(registrar:FlutterPluginRegistrar){
        self.registrar = registrar
    }
    
    deinit {
        registrar = nil
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let view = FlutterTextView(frame, viewId:viewId, args:args)
        if let reg = registrar {
            view.createChannel(registrar: reg)
        }
        return view
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

public class FlutterTextView : NSObject, FlutterPlatformView {
    public static let viewType = "learning_flutter_plugin/text_view"
    
    let frame : CGRect
    let viewId : Int64
    private let args:[String:Any]?
    weak var referenceView:UITextField?
    
    init(_ frame:CGRect, viewId:Int64, args: Any?){
        self.frame = frame
        self.viewId = viewId
        self.args = args as? [String:Any]
    }
    
    deinit {
        referenceView = nil
    }
    
    public func view() -> UIView {
        if referenceView == nil  {
            createView()
        }
        return referenceView!
    }
    
    private func createView(){
        let view = UITextField(frame: self.frame)

        var text = "iOS - UITextField"
        if let tArg = args?["text"] as? String {
            text = tArg
        }

        view.text = text
        
        referenceView = view
    }
}

/*
 Implementar FlutterPlugin é necessário somente se for preciso criar um canal de comunicação para essa view.
 */
extension FlutterTextView:FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        //not implemented
    }
    
    public func createChannel(registrar:FlutterPluginRegistrar){
        let channel = FlutterMethodChannel(name: FlutterTextView.viewType+"_\(self.viewId)", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setText":
            setText(call.arguments as? String, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func setText(_ text:String?, result:@escaping FlutterResult) {
        self.referenceView?.text = text
        result(true)
    }
}
