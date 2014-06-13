//
//  ViewController.m
//  Diet
//
//  Created by 藤浦ゆず on 2014/05/03.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import "ViewController.h"

@implementation CameraOverlayView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pickerController takePicture];
}

@end

@interface ViewController()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    //
    UIImageView* newImageView;
    newImageView = [[UIImageView alloc] init];
    newImageView.frame = self.view.bounds;
    newImageView.contentMode = UIViewContentModeScaleAspectFit;
    //newImageView.autoresizingMask =
    //UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)takePhoto{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.sourceType = sourceType;
        
        picker.delegate = self;
        
        UIImage *image = [UIImage imageNamed:@"waku.png"];
        CameraOverlayView *overlayView = [[CameraOverlayView alloc] initWithImage:image];
        overlayView.pickerController = picker;
        
        overlayView.frame = CGRectMake(0, 45, 320, 590);//大きさと座標を決める
        overlayView.contentMode = UIViewContentModeScaleAspectFit;//AspectFill
        //overlayView.autoresizingMask =
        //UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.alpha = 1.0;
        overlayView.userInteractionEnabled = NO;
        
        picker.cameraOverlayView = overlayView;
        
        
        //昨日の画像を上にのせる
        
        
         UIImageView *yesterdaywakuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 70, 100)];
        yesterdaywakuImageView.image = [UIImage imageNamed:@"waku.png"];
        yesterdaywakuImageView.alpha = 1.0;
        
        UIImageView *yesterdayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 70, 100)];
        yesterdayImageView.image = [UIImage imageNamed:@"Masu-.png"];
        yesterdayImageView.alpha = 1.0;
        
        [overlayView addSubview:yesterdayImageView];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}

-(IBAction)openLibrary{

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = sourceType;
        
        picker.delegate = self;
        
        UIImage *image = [UIImage imageNamed:@"waku.png"];
        CameraOverlayView *overlayView = [[CameraOverlayView alloc] initWithImage:image];
        overlayView.pickerController = picker;
        
        overlayView.frame = CGRectMake(0, 44, 320, 454);//大きさと座標を決める
        overlayView.contentMode = UIViewContentModeScaleAspectFit;//AspectFill
        //overlayView.autoresizingMask =
        //UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.alpha = 1.0;
        overlayView.userInteractionEnabled = NO;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
   
}


-(void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    
    
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // カメラ
        imageview.alpha = 0.6;
        [imageview setImage:image];
        
        UIImageWriteToSavedPhotosAlbum(
                                       image,
                                       self,
                                       @selector(targetImage:didFinishSavingWithError:contextInfo:),
                                       NULL);
    }else{
        // ライブラリ
        imageview2.contentMode = UIViewContentModeScaleAspectFit;
        imageview2.alpha = 1.0;
 
        [imageview2 setImage:image];
        
    }
}



-(void)targetImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context{
    
    
    if(error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"保存できませんでした"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"保存を完了しました"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerContrrollerDidCancel:(UIImagePickerController *)picker {
    UIViewController *vc = [picker presentingViewController];
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)postToFacebook{
    
    NSString *serviceType = SLServiceTypeFacebook;
    
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *facebookPostVC = [[SLComposeViewController alloc] init];
        
        facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        [facebookPostVC setInitialText:@"#LITech #techCamera"];
        
        [facebookPostVC addImage:imageview.image];
        
        [facebookPostVC setCompletionHandler:^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                               message:@"投稿を完了しました"
                                      　　　　　　　　　　　　　　 delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                                      [alert show];
                                      }else{
                                     
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                                          message:@"投稿できませんでした"
                                                                　　　　　　　　　　　　　　delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];

                                                                [alert show];
                               
    　　　　　　　　}
　　　　　}];
                
        [self presentViewController:facebookPostVC animated:YES completion:nil];
    }else {
        
    }
}



@end
