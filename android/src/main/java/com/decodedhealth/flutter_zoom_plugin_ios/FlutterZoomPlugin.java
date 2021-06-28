package com.decodedhealth.flutter_zoom_plugin_ios;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterZoomPlugin */
public class FlutterZoomPlugin {

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    registrar.platformViewRegistry().registerViewFactory("flutter_zoom_plugin_ios", new ZoomViewFactory(registrar.messenger()));
  }
}
