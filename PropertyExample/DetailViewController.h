//
//  DetailViewController.h
//  PropertyExample
//
//  Created by Jose Colella on 10/03/2014.
//  Copyright (c) 2014 Jose Colella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL * blogPostURL;
@end
