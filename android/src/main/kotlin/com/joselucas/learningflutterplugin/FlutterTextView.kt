package com.joselucas.learningflutterplugin

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformView

/*
* Implementar 'MethodCallHandler' é necessário somente se for preciso criar um canal de comunicação
* com essa View, o mesmo se aplica para o metodo 'createChannel'
*
* */
class FlutterTextView internal constructor(private val context: Context?,private val id: Int, private val args:Any?) : PlatformView, MethodCallHandler {

    companion object {
        const val ViewType:String = "learning_flutter_plugin/text_view"
    }

    private var textView: TextView? = null

    @Override
    override fun getView(): View {
        if(textView == null)
            createTextView()
        return textView!!
    }

    @Override
    override fun onMethodCall(methodCall: MethodCall, result: Result) {
        when (methodCall.method) {
            "setText" -> setText(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun setText(methodCall: MethodCall, result: Result) {
        val text = methodCall.arguments as String
        textView?.setText(text)
        result.success(null)
    }

    @Override
    override fun dispose() {
        textView = null
    }

    init {
        createTextView()
    }

    private fun createTextView() {
        textView = TextView(context)

        var text:String? = "Android - TextView"
        (args as? HashMap<String,*>)?.let { mapArgs ->
            text = mapArgs["text"] as? String
        }

        textView?.setText(text)

    }

    fun createChannel(messenger: BinaryMessenger?){
        val methodChannel = MethodChannel(messenger, "${FlutterTextView.ViewType}_$id")
        methodChannel.setMethodCallHandler(this)
    }
}