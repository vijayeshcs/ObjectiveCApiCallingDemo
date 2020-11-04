//
//  NetworkApi.h
//  TestFyber
//
//  Created by Vijayesh on 22/10/20.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NetworkApiDelegate <NSObject>

-(void)didUpdateData:(DataModel *)data;
-(void)didFailWithError:(NSString*)errMessage;

@end
@interface NetworkApi : NSObject
@property (nonatomic,strong)id<NetworkApiDelegate> delegate;
-(void) fetchJSON:(NSString*)appID userID:(NSString *)userID token:(NSString*)token;
@end

NS_ASSUME_NONNULL_END
