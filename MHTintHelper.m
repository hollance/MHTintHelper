
#import "MHTintHelper.h"

static const NSInteger MHTintHelperTag = 77777777;

@interface MHTintHelper ()
@property (nonatomic, retain) NSArray  *items;
@property (nonatomic, retain) UISlider *redSlider;
@property (nonatomic, retain) UILabel  *redLabel;
@property (nonatomic, retain) UISlider *greenSlider;
@property (nonatomic, retain) UILabel  *greenLabel;
@property (nonatomic, retain) UISlider *blueSlider;
@property (nonatomic, retain) UILabel  *blueLabel;
@end

@implementation MHTintHelper

@synthesize items       = _items;
@synthesize redSlider   = _redSlider;
@synthesize redLabel    = _redLabel;
@synthesize greenSlider = _greenSlider;
@synthesize greenLabel  = _greenLabel;
@synthesize blueSlider  = _blueSlider;
@synthesize blueLabel   = _blueLabel;

+ (void)showInView:(UIView *)view forItem:(id)item
{
	return [MHTintHelper showInView:view forItems:[NSArray arrayWithObject:item]];
}

+ (void)showInView:(UIView *)view forItems:(NSArray *)items
{
	MHTintHelper *helper = [[MHTintHelper alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
	helper.items = items;
	helper.tag = MHTintHelperTag;
	helper.center = CGPointMake(view.bounds.size.width/2.0f, view.bounds.size.height/2.0f);
	[view addSubview:helper];
	[helper release];
}

+ (NSInteger)tag
{
	return MHTintHelperTag;
}

- (void)update
{
	UIColor *color = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:1.0f];
	self.backgroundColor = color;

	self.redLabel.text = [NSString stringWithFormat:@"%d=%g", (int)roundf(self.redSlider.value*255.0f), self.redSlider.value];
	self.greenLabel.text = [NSString stringWithFormat:@"%d=%g", (int)roundf(self.greenSlider.value*255.0f), self.greenSlider.value];
	self.blueLabel.text = [NSString stringWithFormat:@"%d=%g", (int)roundf(self.blueSlider.value*255.0f), self.blueSlider.value];

	UIColor *textColor;
	if (self.redSlider.value + self.greenSlider.value + self.blueSlider.value < 1.5f)
		textColor = [UIColor whiteColor];
	else
		textColor = [UIColor blackColor];

	self.redLabel.textColor = textColor;
	self.greenLabel.textColor = textColor;
	self.blueLabel.textColor = textColor;

	for (id item in self.items)
	{
		if ([item respondsToSelector:@selector(setTintColor:)])
			[item setTintColor:color];
	}
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
		                      | UIViewAutoresizingFlexibleRightMargin
		                      | UIViewAutoresizingFlexibleTopMargin
		                      | UIViewAutoresizingFlexibleBottomMargin;

		for (int t = 0; t < 3; ++t)
		{
			UISlider *theSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 10 + t*40, 256, 23)];
			theSlider.minimumValue = 0.0f;
			theSlider.maximumValue = 1.0f;
			theSlider.value = 0.5f;
			theSlider.autoresizingMask = 0;
			[theSlider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
			[self addSubview:theSlider];
			[theSlider release];

			UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(256, 10 + t*40, 64, 23)];
			theLabel.font = [UIFont systemFontOfSize:11.0f];
			theLabel.backgroundColor = [UIColor clearColor];
			theLabel.lineBreakMode = UILineBreakModeClip;
			theLabel.autoresizingMask = 0;
			[self addSubview:theLabel];
			[theLabel release];

			if (t == 0)
			{
				self.redSlider = theSlider;
				self.redLabel = theLabel;
			}
			else if (t == 1)
			{
				self.greenSlider = theSlider;
				self.greenLabel = theLabel;
			}
			else
			{
				self.blueSlider = theSlider;
				self.blueLabel = theLabel;
			}
		}

		[self update];
	}
	return self;
}

- (void)dealloc
{
	[_items release];
	[_redSlider release];
	[_redLabel release];
	[_greenSlider release];
	[_greenLabel release];
	[_blueSlider release];
	[_blueLabel release];
	[super dealloc];
}

- (void)sliderMoved:(UISlider *)slider
{
	[self update];
}

@end
