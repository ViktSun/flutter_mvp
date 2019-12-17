package com.vicksun.flutter_mvp

import com.tencent.bugly.crashreport.CrashReport
import io.flutter.app.FlutterApplication

/**
 * PackageName : com.vicksun.flutter_mvp <br/>
 *
 * Creator : sun <br/>
 *
 * CreateDate : 2019-12-17 <br/>
 *
 * CreateTime : 09 : 48 <br/>
 *
 * Description :
 */
public class MyApp :FlutterApplication(){

  override fun onCreate() {
    super.onCreate()
    CrashReport.initCrashReport(applicationContext,"42322593e2",true)
  }
}