//
//  MasterViewController.m
//  PropertyExample
//
//  Created by Jose Colella on 10/03/2014.
//  Copyright (c) 2014 Jose Colella. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "BlogReader.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)viewDidLoad
{
    
    self.blogReader = [[BlogReader alloc] initWithUrl:@"http://programacionmovilesugr.blogspot.com.es"];
    [self.blogReader saveToPlist];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.blogReader size];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //Getting the raw data from the url of the icon
    NSURL * icon = [NSURL URLWithString:[self.blogReader.blogPostURLArray objectAtIndex:indexPath.row]];
   
    NSData * imageData = [NSData dataWithContentsOfURL:icon];
    if ([imageData length] != 0) {
        cell.imageView.image = [UIImage imageWithData:imageData];
        
    } else {
        cell.imageView.image = [UIImage  imageNamed:@"logo"];
    }
    
    NSString * postText = [self.blogReader.blogPostTitleArray objectAtIndex:indexPath.row];
    if ([postText hasPrefix:@"["]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = postText;
    cell.detailTextLabel.text = [self.blogReader urltAtIndex:indexPath.row];
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        [(DetailViewController *)segue.destinationViewController setBlogPostURL:[NSURL URLWithString:[self.blogReader urltAtIndex:indexPath.row]]];
        
        
        
    }
}

@end
