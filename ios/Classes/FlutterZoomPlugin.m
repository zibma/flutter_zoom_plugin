#import "FlutterZoomPlugin.h"
#import <flutter_zoom_plugin_ios/flutter_zoom_plugin_ios-Swift.h>

@implementation FlutterZoomPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterZoomPlugin registerWithRegistrar:registrar];
}
@end
