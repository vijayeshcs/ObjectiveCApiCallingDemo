//
//  ViewController.m
//  TestFyber
//
//  Created by Vijayesh on 21/10/20.
//

#import "ViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import "OffersTableViewCell.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/utsname.h>



@interface ViewController ()
{
    NSMutableArray *titleArr; //title array of all the offers
    NSMutableArray *imageArr; // image array of all the offers
    NSCache *imagesCache; // image cache so that it does not download everytime when tableview is scrolled
    
}

@end

@implementation ViewController
@synthesize offersTableView;
@synthesize appID,userID,token;

//MARK: viewDidLoad. Network call, settign Delegate, initializing cache  and registering nib file.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NetworkApi * api = [[NetworkApi alloc]init];
    [api fetchJSON:self.appID userID:self.userID token:self.token];
    [self.activityIndicator startAnimating];
    api.delegate = self;
    self.offersTableView.delegate = self;
    self.offersTableView.dataSource = self;
    [self.offersTableView registerNib:[UINib nibWithNibName:@"OffersTableViewCell" bundle:nil]forCellReuseIdentifier:@"OffersTableViewCell"];
    imagesCache = [[NSCache alloc] init];
    
    
}

//MARK: Tableview Delegates.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OffersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffersTableViewCell"];
    
    cell.offerLabel.text = titleArr[indexPath.row];
    NSString *stringWithImgURL = imageArr[indexPath.row][@"lowres"];
    
    //Implementation of cache
    if (![imagesCache objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]){
        NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringWithImgURL]] ;
        [imagesCache setObject:imgData forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        cell.imgView.image = [UIImage imageWithData:imgData];
    }else{
        cell.imgView.image =[UIImage imageWithData:[imagesCache objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]];
    }
    return cell;
}


//MARK: Network class callback for successful data fetching and populating it in tableview

-(void)didUpdateData:(nonnull DataModel *)data {
    
    //Data loading and reloading the tableview
    [self.activityIndicator stopAnimating];
    titleArr = [[NSMutableArray alloc]initWithArray:data.titleArray];
    imageArr = [[NSMutableArray alloc]initWithArray:data.imgArray];
    [self.offersTableView reloadData];
    
}

//MARK: Network class callback when error is thrown

-(void)didFailWithError:(NSString *)errMessage{
    
    //Displaying error message in alertViewController
    [self.activityIndicator stopAnimating];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:errMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end
