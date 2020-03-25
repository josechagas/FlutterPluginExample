//
//  Teste.swift
//  Runner
//
//  Created by José Lucas Souza das Chagas on 23/03/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Flutter
import UIKit

public class TesteTextViewFactory : NSObject, FlutterPlatformViewFactory {

    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return TesteTextView(frame, viewId:viewId, args:args)
    }
}

public class TesteTextView : NSObject, FlutterPlatformView {

    let frame : CGRect
    let viewId : Int64

    init(_ frame:CGRect, viewId:Int64, args: Any?){
        self.frame = frame
        self.viewId = viewId
    }

    public func view() -> UIView {
        let view : UIView = UIView(frame: self.frame)
        //view.text = "Testando"
        view.backgroundColor = UIColor.red
        //view.tag = Int(viewId)
        return view
    }

}
