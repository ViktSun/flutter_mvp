package com.vicksun.flutter_mvp

import android.os.Bundle
import com.elvishew.xlog.LogConfiguration
import com.elvishew.xlog.LogLevel
import com.elvishew.xlog.XLog
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    // 指定日志级别，低于该级别的日志将不会被打印，默认为 LogLevel.ALL
    val logLevel = if (BuildConfig.DEBUG) LogLevel.ALL else LogLevel.NONE
    val config = LogConfiguration.Builder().logLevel(logLevel).build()
    XLog.init(config)

    MethodChannel(flutterView, "x_log").setMethodCallHandler { methodCall, _ ->
      logPrint(methodCall)
    }
  }

  private fun logPrint(call: MethodCall) {
    val tag: String? = call.argument("tag")
    val message: String? = call.argument("msg")

    when (call.method) {
      "logD" -> XLog.tag(tag).d(message)
      "logW" -> XLog.tag(tag).w(message)
      "logI" -> XLog.tag(tag).i(message)
      "logE" -> XLog.tag(tag).e(message)
      "logJson" -> XLog.tag(tag).json(message)
      else -> XLog.tag(tag).v(message)
    }
  }
}
