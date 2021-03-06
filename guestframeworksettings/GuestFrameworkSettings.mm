#import <Preferences/Preferences.h>
#import <objc/runtime.h>
#import "GuestFrameworkSettings.h"
#import <LibGuest/LibGuest.h>

@interface PSListController (LibGuest)
-(void)viewDidLoad;
@end

static GuestFrameworkSettingsListController *sharedController;
PSSpecifier *pluginCell;

@implementation GuestFrameworkSettingsListController

+(instancetype) sharedController
{
    return sharedController;
}

-(id)initForContentSize:(CGSize)contentSize
{
    self = [super initForContentSize:contentSize];
    sharedController = self;
    return self;
}
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"GuestFrameworkSettings" target:self];
        [self localizedSpecifiersWithSpecifiers:_specifiers];
        
        for (PSSpecifier *specifier in _specifiers) {
            if ([[specifier identifier] isEqualToString:@"Plugins"])
            {
                [specifier setProperty:[NSNumber numberWithInteger:52*[[LibGuest sharedInstance]->delegates count] ] forKey:@"height"];
                pluginCell = specifier;
            }
        }
    }
	return _specifiers;
}
- (id)navigationTitle {
	return [[self bundle] localizedStringForKey:[super title] value:[super title] table:nil];
}

- (id)localizedSpecifiersWithSpecifiers:(NSArray *)specifiers {
	for(PSSpecifier *curSpec in specifiers) {
		NSString *name = [curSpec name];
		if(name) {
			[curSpec setName:[[self bundle] localizedStringForKey:name value:name table:nil]];
		}
		NSString *footerText = [curSpec propertyForKey:@"footerText"];
		if(footerText)
			[curSpec setProperty:[[self bundle] localizedStringForKey:footerText value:footerText table:nil] forKey:@"footerText"];
		id titleDict = [curSpec titleDictionary];
		if(titleDict) {
			NSMutableDictionary *newTitles = [[NSMutableDictionary alloc] init];
			for(NSString *key in titleDict) {
				NSString *value = [titleDict objectForKey:key];
				[newTitles setObject:[[self bundle] localizedStringForKey:value value:value table:nil] forKey: key];
			}
			[curSpec setTitleDictionary:newTitles];
		}
	}
	return specifiers;
}

-(void) setPluginCellHeight:(CGFloat)height
{
    NSLog(@"pluginCell %d", (int)height);
    [pluginCell setProperty:[NSNumber numberWithFloat:height] forKey:@"height"];
}
@end

#define WBSAddMethod(_class, _sel, _imp, _type) \
if (![[_class class] instancesRespondToSelector:@selector(_sel)]) \
class_addMethod([_class class], @selector(_sel), (IMP)_imp, _type)

id $PSViewController$initForContentSize$(PSRootController *self, SEL _cmd, CGRect contentSize) {
    return [self init];
}
static __attribute__((constructor)) void __wbsInit() {
    WBSAddMethod(PSViewController, initForContentSize:, $PSViewController$initForContentSize$, "@@:{ff}");
}