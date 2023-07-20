#import <Foundation/Foundation.h>
#import "FLEXRootListController.h"
#import "FlexInjectCenter.h"
#import "FlexInjectApp.h"

@implementation FLEXRootListController

- (NSMutableArray *)specifiers {
	NSMutableArray *sps = [NSMutableArray array];
	if (!_specifiers) {

		// [sps addObjectsFromArray:[self loadSpecifiersFromPlistName:@"Root" target:self]];
        [[FlexInjectCenter shareInstances] refreshAllApps];
        for (FlexInjectApp *app in [FlexInjectCenter shareInstances].injectApps) {
			PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:app.applicationProxy.localizedName target:app set:@selector(switchChanged:) get:@selector(getSwitchValue) detail:nil cell:PSSwitchCell edit:nil];
			NSBundle *b = [NSBundle bundleWithURL:app.applicationProxy.bundleURL];
			if (b) {
				NSString *icon = [[b.infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
				NSString *iconPath = [NSString stringWithFormat:@"%@/%@.png", b.bundlePath, icon];
				UIImage *iconImage = [UIImage imageWithContentsOfFile:iconPath];

				CGSize iconSize = CGSizeMake(30.0, 30.0); // 自定义图标大小
				UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
				CGRect iconRect = CGRectMake(0.0, 0.0, iconSize.width, iconSize.height);
				[[UIBezierPath bezierPathWithRoundedRect:iconRect cornerRadius:5.0] addClip];
				[iconImage drawInRect:iconRect];
				UIImage *processedIcon = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();

				[specifier setProperty:processedIcon forKey:@"iconImage"];
			}
			[sps addObject:specifier];
		}
		_specifiers = sps;
	}

	return _specifiers;
}


@end
