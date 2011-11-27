
#import "ViewController.h"
#import "MHTintHelper.h"

@implementation ViewController

@synthesize navigationBar;
@synthesize toolbar;
@synthesize segmentedControl;
@synthesize barButtonItem;

- (void)viewDidLoad
{
	[super viewDidLoad];

	[MHTintHelper showInView:self.view forItems:[NSArray arrayWithObjects:self.navigationBar, self.toolbar, self.segmentedControl, self.barButtonItem, nil]];

	NSLog(@"MHTintHelper = %@", [self.view viewWithTag:[MHTintHelper tag]]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
