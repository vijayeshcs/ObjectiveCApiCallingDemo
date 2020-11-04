//
//  NetworkApi.m
//  TestFyber
//
//  Created by Vijayesh on 22/10/20.
//

#import "NetworkApi.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
@implementation NetworkApi
@synthesize delegate;


// MARK: creating the nsurl string with this function. If not using simulator then uncomment the code for phone version and apple idfa.

-(void) fetchJSON:(NSString*)appID userID:(NSString *)userID token:(NSString*)token{
    NSString *timestamp = [NSString stringWithFormat:@"%lu", (long)[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];
    NSLog(@"%@",timestamp);
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    //    struct utsname systemInfo;
    //    uname(&systemInfo);
    //    NSString* phone_version = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *phone_version = @"iPod7,1";
    //NSString *apple_idfa = [[[[ASIdentifierManager sharedManager] advertisingIdentifier]UUIDString] valueForKey:@"apple_idfa"];
    NSString *apple_idfa = @"00000000-0000-0000-0000-000000000000";
    NSString *apple_idfa_tracking_enabled = @"true";
    NSString *ip = @"109.235.143.113";
    NSString *locale = @"DE";
    NSString *offerTypes = @"112";
    
    
    NSString * urlParams = [NSString stringWithFormat:@"appid=%@"
                            @"&apple_idfa=%@"
                            @"&apple_idfa_tracking_enabled=%@"
                            @"&ip=%@&locale=%@"
                            @"&offer_types=%@"
                            @"&os_version=%@"
                            @"&phone_version=%@"
                            @"&timestamp=%@"
                            @"&uid=%@"
                            @"&",appID,apple_idfa,apple_idfa_tracking_enabled,ip,locale,offerTypes,osVersion,phone_version,timestamp,userID];
    
    
    //generating the hashkey
    NSString *hashKeyGeneratorStr = [NSString stringWithFormat:@"%@%@",urlParams,token];
    
    NSString *hashKey = [self sha1:hashKeyGeneratorStr];
    
    // main url ready
    NSString *mainstr = [NSString stringWithFormat:@"https://api.fyber.com/feed/v1/offers.json?%@hashkey=%@",urlParams,hashKey];
    
    // Data fething called
    [self executequery:mainstr];
    
}



//MARK: Fetching the json

-(void)executequery:(NSString *)strurl{
    DataModel *model = [[DataModel alloc]init];
    //Step:-1 Session Create
    NSURLSessionConfiguration *defaultconfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];//New Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultconfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];//Queue is Stroing and retrieve data FIFO
    
    NSURL *urlrequest = [NSURL URLWithString:strurl];
    NSMutableURLRequest*mutablerequest = [NSMutableURLRequest requestWithURL:urlrequest];
    
    [mutablerequest setHTTPMethod:@"GET"];//Adding Data is Url With Json
    NSURLSessionDataTask * task = [session dataTaskWithRequest:mutablerequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
        if (data!=nil)
        {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            // Getting the required objects for our model
            
            model.titleArray = [[NSMutableArray alloc]init];
            model.imgArray = [[NSMutableArray alloc]init];
            
            if([[dataDictionary objectForKey:@"code"] isEqual: @"OK"]){ // checking if the code is "OK "
                NSArray *arr = [dataDictionary objectForKey:@"offers"];
                for (NSDictionary *dict in arr) {
                    [model.titleArray addObject:[dict objectForKey:@"title"]];
                    [model.imgArray addObject:[dict objectForKey:@"thumbnail"]];
                    
                }
                //Delegate method for correctly fetched data
                [self->delegate didUpdateData:model];
                NSLog(@"Response %@", data);
            }
            else{
                //Delegate method after an error with code
                [self->delegate didFailWithError:[dataDictionary objectForKey:@"code"]];
            }
        }
        else
        {
            //Delegate method after an error with any nserror
            [self->delegate didFailWithError:error.localizedDescription];
            NSLog(@"error");
        }
    }];
    [task resume];
    
    
}


//MARK: SHA method opted from stackoverflow

- (NSString *)sha1:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
