
#import "ViewController.h"
#import "MHTintHelper.h"

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[MHTintHelper showInView:self.view forItems:@[self.navigationBar, self.toolbar, self.segmentedControl, self.barButtonItem]];

	NSLog(@"MHTintHelper = %@", [self.view viewWithTag:[MHTintHelper tag]]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
