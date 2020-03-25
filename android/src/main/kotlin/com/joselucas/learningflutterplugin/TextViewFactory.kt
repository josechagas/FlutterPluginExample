package com.joselucas.learningflutterplugin

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/*
* O 'PlatformViewFactory' so precisa de uma referencia para 'BinaryMessenger' se
* a 'View' que ele vai criar precisa ter um canal para comunicação.
* */
class TextViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any): PlatformView {
        val view = FlutterTextView(context, id, args)
        view.createChannel(messenger)
        return view
    }

}