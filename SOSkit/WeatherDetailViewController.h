//
//  WeatherDetailViewController.h
//  SOSkit
//
//  Created by Amisha Goyal on 9/28/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
@interface WeatherDetailViewController : UIViewController

@property (nonatomic,strong) City *city;
-(void)setUpView;
@end
