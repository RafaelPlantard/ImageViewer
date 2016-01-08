//
//  ViewController.h
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! @brief Controller for the HomeView. */
@interface IVViewController : UIViewController<UIScrollViewDelegate>

/*! @brief The scroll viewer component to show the images. */
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

/*! @brief Represents the elements that I recover from a json response. */
@property (retain, nonatomic) NSArray *elements;

/*! @brief The list of images. */
@property (retain, nonatomic) NSMutableArray *images;

@end