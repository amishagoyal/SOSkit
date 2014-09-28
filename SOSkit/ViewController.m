//
//  ViewController.m
//  SOSkit
//
//  Created by Amisha Goyal on 9/23/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "ViewController.h"
#import "City.h"
#import <SOS/SOS.h>
#import "WeatherDetailViewController.h"
static NSString * const BaseURLString = @"http://localhost:6080/RESTService-0.1/";
@interface SOSSessionManager(Beta)
+ (BOOL) enableNetworkSpeedTest;
@end

@implementation SOSSessionManager(Beta)
+ (BOOL) enableNetworkSpeedTest {
    return NO;
}
@end
@interface ViewController (){

}
- (IBAction)startSession:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startSOSButton;
@property (strong,nonatomic) NSMutableArray *cities;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _cities = [NSMutableArray array];
    self.title =@"Cities";
    [self requestForData];
}

/*
This method uses the AFNetworking framework to handle the request /response to the server.
It also helps in serializing the JSOn response recieved.
*/

- (void)requestForData
{
    NSString *string = [NSString stringWithFormat:@"%@city/index", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        /*
         Handle the data mapping and add the city objects to an array _cities.
         */
        [_cities removeAllObjects];
        for(NSDictionary *dataDictionary in (NSArray*)responseObject){
            City *city = [[City alloc] init];
            city.name = [dataDictionary valueForKey:@"cityName"];
            city.country = [dataDictionary valueForKey:@"country"];
            city.postalCode = [dataDictionary valueForKey:@"postalCode"];
            city.temperature = [dataDictionary valueForKey:@"temperature"];
            city.weatherCondition = [dataDictionary valueForKey:@"weatherCondition"];
            city.weatherImageURL = [dataDictionary valueForKey:@"image"];
            [_cities addObject:city];
            city =nil;
        }
        // reload the table view with the response data.
        [self.resultTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" ];
    }
    City *city = [_cities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_cities count];
}

/*
Load the weather detail view controller with the details of each city.
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherDetailViewController *detailController = [[WeatherDetailViewController alloc] initWithNibName:@"WeatherDetailViewController" bundle:nil];
    detailController.city = [_cities objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
Action to start the SOS session */
- (IBAction)startSession:(id)sender {
    NSLog(@"start session clicked *****************");

    SOSOptions *sosOpts = [SOSOptions optionsWithEmail:@"amisha.goyal@salesforce.com"
                                          liveAgentPod:@"d.la.gus.salesforce.com"
                                                 orgId:@"00DB00000000sHB"
                                          deploymentId:@"572B000000001hv"]; 
    [[[SOSSessionManager sharedInstance] uiComponents] setConnectMessage:@"Are you ready to experience the Future of Customer Service?"];
    [sosOpts setEnvironment:SOSEnvironmentPreRelease];
    
    [[SOSSessionManager sharedInstance] startSessionWithOptions:sosOpts completion:^(NSError *error, SOSSessionManager *sos) {
        if (error) {
            // There was a problem starting the session
            NSLog(@"Error starting the session: %@", error);
            return;
        }
        else{
            NSLog(@"SOS session started.");
        }
        // Session started!
    }];
    
}

@end
