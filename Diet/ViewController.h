//
//  ViewController.h
//  Diet
//
//  Created by 藤浦ゆず on 2014/05/03.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraOverlayView : UIImageView

@property UIImagePickerController *pickerController;

@end


@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *imageview;
    IBOutlet UIImageView *imageview2;

}

-(IBAction)takePhoto;

-(IBAction)openLibrary;

-(IBAction)postTotwitter;

-(IBAction)postToFacebook;

-(IBAction)postToLINE;

@end