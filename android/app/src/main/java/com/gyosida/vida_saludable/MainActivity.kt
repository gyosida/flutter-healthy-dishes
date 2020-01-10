package com.gyosida.vida_saludable;

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity : FlutterActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    GeneratedPluginRegistrant.registerWith(ShimPluginRegistry(flutterEngine))
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "updateFavorite") {
        println(">>>>>> updateFavorite got called!")
        val boolean = call.argument<Boolean>("isFavorite")!!
        result.success(!boolean)
      } else {
        result.notImplemented()
      }
    }
  }

  companion object {
    const val CHANNEL = "lib.view/favorite"
  }
}
