//
//  OffersTableViewCell.h
//  TestFyber
//
//  Created by Vijayesh on 22/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//custom tableview cell
@interface OffersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;

@end

NS_ASSUME_NONNULL_END
