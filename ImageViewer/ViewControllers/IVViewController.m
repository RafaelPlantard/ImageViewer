//
//  ViewController.m
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "IVViewController.h"
#import "IVApiManager.h"
#import "UIImageView+AFNetworking.h"

@interface IVViewController ()

@end

@implementation IVViewController

/*! @brief Do a request for the 500px api. */
- (void)doRequest {
    [[IVApiManager sharedManager] getPhotos:^(id json) {
        _elements = json[@"photos"];
        
        [self showMessage:[NSString stringWithFormat:@"%lu images found", _elements.count]];
        
        if (_elements.count > 0) {
            [self initScrollView];
        }
    } failure:^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
    }];
}

/*! @brief Load the remote image on the respective UIImageView on UIScrollView. */
- (void)loadRemoteImage:(int)index {
    //
    currentPage = index;
    
    NSDictionary *photoItem = _elements[index];
    
    NSDictionary *imageItem = photoItem[@"images"][0];
    
    NSString *url = imageItem[@"url"];
    
    NSLog(@"Loading the URL %@", url);
    
    UIImageView *image = _images[index];
    
    image.contentMode = UIViewContentModeScaleAspectFit;
    
    [image setImageWithURL:[NSURL URLWithString:url]];
}

/*! @brief Shows a alert controller with a message. */
- (void)showMessage:(NSString *)message {
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"continue" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"500px Image Viewer" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:continueAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Override methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize scrollFrameSize = _imageScrollView.frame.size;
    
    int height = scrollFrameSize.height;
    int width = scrollFrameSize.width;
    
    _imageScrollView.contentSize = CGSizeMake(width * _elements.count, height);
    
    int index = 0;
    for (UIImageView *imageView in _imageScrollView.subviews) {
        CGSize imageFrameSize = imageView.frame.size;
        
        if ((imageFrameSize.height > 7) && (imageFrameSize.width > 7)) {
            imageView.frame = CGRectMake(index++ * width, 0, width, height);
        }
    }
    
    CGPoint updatedOffset = CGPointMake(currentPage * width, 0);
    
    [_imageScrollView setContentOffset:updatedOffset animated:YES];
}



- (void)initScrollView {
    CGSize scrollSize = _imageScrollView.bounds.size;
    
    float width = scrollSize.width;
    float height = scrollSize.height;
    
    _imageScrollView.contentSize = CGSizeMake(width * _elements.count, height);
    _imageScrollView.pagingEnabled = YES;
    
    _images = [NSMutableArray new];
    
    // Creates all places where an image can appear, to turn more easy the stuff on time to show the images.
    [_elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect initialFrame = CGRectMake(idx * width, 0, width, height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:initialFrame];
        
        [_imageScrollView addSubview:imageView];
        [_images addObject:imageView];
    }];
    
    // Adds the first image just to don't stay with a blank screen.
    [self loadRemoteImage:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int x = _imageScrollView.contentOffset.x;
    int weight = _imageScrollView.frame.size.width;
    
    // Only load the next image whether the scroll has stopped in a page.
    if ((x % weight) == 0) {
        int page = x / weight;
        
        [self loadRemoteImage:page];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self doRequest];
}



@end