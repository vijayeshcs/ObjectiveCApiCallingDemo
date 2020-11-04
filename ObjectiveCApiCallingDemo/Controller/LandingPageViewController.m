//
//  LandingPageViewController.m
//  TestFyber
//
//  Created by Vijayesh on 22/10/20.
//

#import "LandingPageViewController.h"
#import "ViewController.h"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
@synthesize appIDTextField,tokenTextfield,userIDTextfield;


//MARK: viewdidload for landing page. Has some mandatory parameters in the beginning.

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSString *appID = @"2070";
    NSString *token = @"1c915e3b5d42d05136185030892fbb846c278927";
    NSString *userID = @"superman";
    appIDTextField.text = appID;
    tokenTextfield.text = token;
    userIDTextfield.text = userID;
}


//MARK: Offer button tapped. The values of textfield are passed to ViewController class.
- (IBAction)offersButtonPressed:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.appID = self.appIDTextField.text;
    controller.token = self.tokenTextfield.text;
    controller.userID = self.userIDTextfield.text;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
