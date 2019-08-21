#import "ImageShareWrapper.h"
#import <image_share/image_share-Swift.h>

@implementation ImageShareWrapper
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [ImageShare registerWithRegistrar:registrar];
}
@end
