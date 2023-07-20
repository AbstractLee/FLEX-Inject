#import <dlfcn.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLEXManager : NSObject
@property (nonatomic, readonly, class) FLEXManager *sharedManager;
- (void)showExplorer;
@end

@interface FLEXShow : NSObject
+ (void)loadFLEX;
@end

@implementation FLEXShow
+ (void)loadFLEX {
	void *f = dlopen("/Library/PreferenceBundles/FLEX.bundle/FLEX", 2);
	if (f) {
    	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showFLEX) name:UIApplicationDidBecomeActiveNotification object:nil];
	}
}
+(void)showFLEX {
	[[NSClassFromString(@"FLEXManager") sharedManager] showExplorer];      
}
@end

%ctor {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.123.flex.plist"];
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    if ([prefs[bundleId] boolValue]) {
        [FLEXShow loadFLEX];
    }
}