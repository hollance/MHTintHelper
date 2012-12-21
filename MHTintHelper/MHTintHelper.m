
#import "MHTintHelper.h"

static const NSInteger MHTintHelperTag = 77777777;

@interface MHTintHelper ()
@property (nonatomic, strong) NSArray  *items;
@property (nonatomic, strong) UISlider *redSlider;
@property (nonatomic, strong) UILabel  *redLabel;
@property (nonatomic, strong) UISlider *greenSlider;
@property (nonatomic, strong) UILabel  *greenLabel;
@property (nonatomic, strong) UISlider *blueSlider;
@property (nonatomic, strong) UILabel  *blueLabel;
@end

@implementation MHTintHelper

+ (void)showInView:(UIView *)view forItem:(id)item
{
	return [MHTintHelper showInView:view forItems:@[item]];
}

+ (void)showInView:(UIView *)view forItems:(NSArray *)items
{
	MHTintHelper *helper = [[MHTintHelper alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 120.0f)];
	helper.items = items;
	helper.tag = MHTintHelperTag;
	helper.center = CGPointMake(view.bounds.size.width/2.0f, view.bounds.size.height/2.0f);
	[view addSubview:helper];
}

+ (NSInteger)tag
{
	return MHTintHelperTag;
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
			UISlider *theSlider = [[UISlider alloc] initWithFrame:CGRectMake(0.0f, 10.0f + t*40.0f, 256.0f, 23.0f)];
			theSlider.minimumValue = 0.0f;
			theSlider.maximumValue = 1.0f;
			theSlider.value = 0.5f;
			theSlider.autoresizingMask = 0;
			[theSlider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
			[self addSubview:theSlider];

			UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(256.0f, 10.0f + t*40.0f, 64.0f, 23.0f)];
			theLabel.font = [UIFont systemFontOfSize:11.0f];
			theLabel.backgroundColor = [UIColor clearColor];
			theLabel.lineBreakMode = UILineBreakModeClip;
			theLabel.autoresizingMask = 0;
			[self addSubview:theLabel];

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

- (void)sliderMoved:(UISlider *)slider
{
	[self update];
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

@end
