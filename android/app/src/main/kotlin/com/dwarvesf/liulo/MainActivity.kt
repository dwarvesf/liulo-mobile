package com.dwarvesf.liulo

import android.os.Bundle

import com.crashlytics.android.Crashlytics;
import io.fabric.sdk.android.Fabric;

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity(): FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    initFabric()
  }

  private fun initFabric() {
    if (!BuildConfig.DEBUG) Fabric.with(this, Crashlytics())
  }
}
