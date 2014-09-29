//
//  WeatherDetailViewController.m
//  SOSkit
//
//  Created by Amisha Goyal on 9/28/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface WeatherDetailViewController ()
@property (nonatomic,strong) IBOutlet UILabel *temperatureLabel;
@property (nonatomic,strong) IBOutlet UILabel *weatherLabel;
@property (nonatomic,strong) IBOutlet UIImageView *weatherImageView;
@end

@implementation WeatherDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
Set up the detail view with the information in the respective city objects.
*/
-(void)setUpView{
    
    self.weatherLabel.text = _city.weatherCondition;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@ ºC",_city.temperature];
    NSLog(@"City :%@",_city);
    NSURL *url = [NSURL URLWithString:_city.weatherImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"Placeholder.pjeg"];
    
    __weak UIImageView *weakImageView = _weatherImageView;
    
    [_weatherImageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakImageView.image = image;
                                       [weakImageView setNeedsLayout];
                                       NSLog(@"success image :%@",image);
                                   } failure:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title= _city.name;
    [self setUpView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
