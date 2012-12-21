
#import "MHTintHelper.h"

static const NSInteger MHTintHelperTag = 77777777;

@interface MHTintHelper ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation MHTintHelper
{
	UISlider *_sliders[3];
	UILabel *_labels[3];
}

+ (void)showInView:(UIView *)view forItem:(id)item
{
	return [MHTintHelper showInView:view forItems:@[item]];
}

+ (void)showInView:(UIView *)view forItems:(NSArray *)items
{
	MHTintHelper *helper = [[MHTintHelper alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 140.0f)];
	helper.items = items;
	helper.tag = MHTintHelperTag;
	helper.center = CGPointMake(view.bounds.size.width/2.0f, view.bounds.size.height/2.0f);
	[view addSubview:helper];
	[helper update];
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
			UISlider *theSlider = [[UISlider alloc] initWithFrame:CGRectMake(10.0f, 10.0f + t*32.0f, 300.0f, 22.0f)];
			theSlider.minimumValue = 0.0f;
			theSlider.maximumValue = 1.0f;
			theSlider.value = 0.5f;
			theSlider.autoresizingMask = 0;
			[theSlider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
			[self addSubview:theSlider];
			_sliders[t] = theSlider;

			UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			theLabel.font = [UIFont systemFontOfSize:12.0f];
			theLabel.textColor = [UIColor whiteColor];
			theLabel.backgroundColor = [UIColor blackColor];
			theLabel.lineBreakMode = UILineBreakModeClip;
			theLabel.textAlignment = UITextAlignmentCenter;
			theLabel.autoresizingMask = 0;
			[self addSubview:theLabel];
			_labels[t] = theLabel;
		}
		
		_labels[0].frame = CGRectMake( 10.0f, 108.0f,  76.0f, 22.0f);
		_labels[1].frame = CGRectMake( 94.0f, 108.0f,  60.0f, 22.0f);
		_labels[2].frame = CGRectMake(162.0f, 108.0f, 148.0f, 22.0f);
	}
	return self;
}

- (void)sliderMoved:(UISlider *)slider
{
	[self update];
}

- (void)update
{
	UIColor *color = [UIColor colorWithRed:_sliders[0].value green:_sliders[1].value blue:_sliders[2].value alpha:1.0f];
	self.backgroundColor = color;

	_labels[0].text = [NSString stringWithFormat:@"%d %d %d",
		(int)roundf(_sliders[0].value*255.0f),
		(int)roundf(_sliders[1].value*255.0f),
		(int)roundf(_sliders[2].value*255.0f)];

	_labels[1].text = [NSString stringWithFormat:@"#%02X%02X%02X",
		(int)roundf(_sliders[0].value*255.0f),
		(int)roundf(_sliders[1].value*255.0f),
		(int)roundf(_sliders[2].value*255.0f)];

	_labels[2].text = [NSString stringWithFormat:@"%0.5f %0.5f %0.5f",
		_sliders[0].value,
		_sliders[1].value,
		_sliders[2].value];

	for (id item in self.items)
	{
		if ([item respondsToSelector:@selector(setTintColor:)])
			[item setTintColor:color];
	}
}

@end
