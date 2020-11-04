//
//  LandingPageViewController.h
//  TestFyber
//
//  Created by Vijayesh on 22/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//Landing page of the application

@interface LandingPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *appIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIDTextfield;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextfield;
- (IBAction)offersButtonPressed:(id)sender;

@end

NS_ASSUME_NONNULL_END
