//
//  City.h
//  SOSkit
//
//  Created by Amisha Goyal on 9/28/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *postalCode;
@property (nonatomic,strong) NSString *temperature;
@property (nonatomic,strong) NSString *weatherImageURL;
@property (nonatomic,strong) NSString *weatherCondition;
@end
