//
// Created by lee on 2023/7/20.
//

#import "FlexInjectCenter.h"
#import "FlexInjectApp.h"


@implementation FlexInjectCenter {

}
+ (instancetype)shareInstances {
    static FlexInjectCenter *ins;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[FlexInjectCenter alloc] init];
    });
    return ins;
}

- (instancetype)init {
    self = [super init];
    self.injectApps = [NSMutableArray array];
    [self loadPref];
    return self;
}

- (void)loadPref {
    self.pref = [[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.123.flex.plist"] mutableCopy];
    if (!self.pref) {
        self.pref = [NSMutableDictionary dictionary];
    }
}

- (void)savePref {
    [self.pref writeToFile:@"/var/mobile/Library/Preferences/com.123.flex.plist" atomically:YES];
}

- (void)refreshAllApps {
    [self.injectApps removeAllObjects];
    LSApplicationWorkspace *workspace = [LSApplicationWorkspace defaultWorkspace];
    NSArray *userApps = [workspace applicationsOfType:0];
    for (LSApplicationProxy *applicationProxy in userApps) {
        FlexInjectApp *flexInjectApp = [[FlexInjectApp alloc] initWithProxy:applicationProxy];
        [self.injectApps addObject:flexInjectApp];
    }
    NSArray *systemApps = [workspace applicationsOfType:1];
    for (LSApplicationProxy *app in systemApps) {
        if (app.primaryIconName && ![app isLaunchProhibited] && ![app.appTags containsObject:@"hidden"]) {
            FlexInjectApp *flexInjectApp = [[FlexInjectApp alloc] initWithProxy:app];
            [self.injectApps addObject:flexInjectApp];
        }
    }
}

- (NSNumber *)getValueByBundleId:(NSString *)bundleId {
    return self.pref[bundleId];
}

- (void)changeValue:(NSNumber *)value byBundleId:(NSString *)bundleId {
    self.pref[bundleId] = value;
    [self savePref];
}
@end