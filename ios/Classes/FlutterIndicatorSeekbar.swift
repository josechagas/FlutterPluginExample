//
//  FlutterIndicatorSeekbar.swift
//  learningflutterplugin
//
//  Created by José Lucas Souza das Chagas on 24/03/20.
//

import Flutter
import UIKit
import RangeSeekSlider


class IndicatorSeekbarFactory:NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterIndicatorSeekbar(frame, viewId: viewId, args: args)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FlutterIndicatorSeekbar:NSObject, FlutterPlatformView {
    
    public static let viewType = "learning_flutter_plugin/indicator_seek_bar"
    
    let frame : CGRect
    let viewId : Int64
    private let args:[String:Any]?
    
    //Nao use 'weak' aqui ou teremos problemas.
    var referenceView:RangeSeekSlider?

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
        let view = RangeSeekSlider(frame: frame)
        
        let max = args?["max"] as? Double ?? 100.0
        let min = args?["min"] as? Double ?? 0.0
        let progress = args?["progress"] as? Double ?? 0.0
        let tickCount = args?["tickCount"] as? Double ?? 1
        let step = (max - min)/tickCount
        
        view.minValue = CGFloat(min)
        view.maxValue = CGFloat(max)
        view.enableStep = true
        view.step = CGFloat(step)
        
        referenceView = view
    }
}
