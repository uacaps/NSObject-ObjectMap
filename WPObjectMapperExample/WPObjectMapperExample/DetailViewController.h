//
//  DetailViewController.h
//  WPObjectMapperExample
//
//  Created by Soper, Sean on 6/25/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

