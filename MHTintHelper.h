/*!
 * \file MHTintHelper.h
 */

#import <UIKit/UIKit.h>

/*!
 * A tool that quickly lets you pick tint colors for navigation bars etc.
 *
 * Simply call showInView:forItem(s): to add the picker panel to your view,
 * run the app and play with the sliders.
 *
 * To get a reference to the MHTintHelper object, query your view for the
 * subview with tag [MHTintHelper tag].
 */
@interface MHTintHelper : UIView

+ (void)showInView:(UIView *)view forItem:(id)item;
+ (void)showInView:(UIView *)view forItems:(NSArray *)items;
+ (NSInteger)tag;

@end
