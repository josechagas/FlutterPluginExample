package com.joselucas.learningflutterplugin

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PlatformInfo : MethodChannel.MethodCallHandler {

    companion object {
        const val Channel = "platform_info"
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }
}