//
// Created by lee on 2023/7/20.
//

#import "FlexInjectApp.h"


@implementation FlexInjectApp {

}
- (instancetype)initWithProxy:(LSApplicationProxy *)proxy {
    if (self = [super init]) {
        _applicationProxy = proxy;
    }

    return self;
}

- (void)switchChanged:(NSNumber *)value {
    [[FlexInjectCenter shareInstances] changeValue:value byBundleId:self.applicationProxy.bundleIdentifier];
}

- (NSNumber *)getSwitchValue {
    return [[FlexInjectCenter shareInstances] getValueByBundleId:self.applicationProxy.bundleIdentifier];
}
@end