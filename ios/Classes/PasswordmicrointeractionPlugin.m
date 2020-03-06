#import "PasswordmicrointeractionPlugin.h"
#if __has_include(<passwordmicrointeraction/passwordmicrointeraction-Swift.h>)
#import <passwordmicrointeraction/passwordmicrointeraction-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "passwordmicrointeraction-Swift.h"
#endif

@implementation PasswordmicrointeractionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPasswordmicrointeractionPlugin registerWithRegistrar:registrar];
}
@end
