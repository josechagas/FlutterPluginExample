package com.joselucas.learningflutterplugin

import androidx.annotation.NonNull;
import com.joselucas.learningflutterplugin.flutterIndicatorSeekBar.FlutterIndicatorSeekbar
import com.joselucas.learningflutterplugin.flutterIndicatorSeekBar.IndicatorSeekbarFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** LearningflutterpluginPlugin */
public class LearningflutterpluginPlugin: FlutterPlugin {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

    flutterPluginBinding.platformViewRegistry.registerViewFactory(FlutterIndicatorSeekbar.ViewType, IndicatorSeekbarFactory())

    flutterPluginBinding.platformViewRegistry.registerViewFactory(FlutterTextView.ViewType, TextViewFactory(flutterPluginBinding.binaryMessenger))

    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), PlatformInfo.Channel)
    channel.setMethodCallHandler(PlatformInfo())
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), PlatformInfo.Channel)
      channel.setMethodCallHandler(PlatformInfo())
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}