# MHTintHelper

Picking the right tintColor for your navigation bars and toolbars can be tricky. This class adds a temporary view with three sliders to your app. You can use it to quickly play with the tint colors until you find one that suits your color scheme.

![Screenshot](https://github.com/hollance/MHTintHelper/raw/master/Screenshot.png)

To use:

    #import "MHTintHelper.h"
    
    - (void)viewDidLoad
    {
        [super viewDidLoad];
        [MHTintHelper showInView:self.view forItem:self.navigationBar];
    }

Works on iOS 4 and iOS 5 (you have to disable ARC for MHTintHelper.m).
