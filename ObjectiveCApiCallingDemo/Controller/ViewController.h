//
//  ViewController.h
//  TestFyber
//
//  Created by Vijayesh on 21/10/20.
//

#import <UIKit/UIKit.h>
#import "NetworkApi.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NetworkApiDelegate>
@property(strong,nonatomic) NSString *appID; // appid property
@property(strong,nonatomic) NSString *userID; // userID property
@property(strong,nonatomic) NSString *token; // token property
@property (weak, nonatomic) IBOutlet UITableView *offersTableView; // tableView 
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



@end

