//
//  GJPlusKeyboardCollectionView+GJPlusDelegate.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJPlusKeyboardCollectionView+GJPlusDelegate.h"

@interface GJPlusKeyboardCollectionView ()<UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation GJPlusKeyboardCollectionView (GJPlusDelegate)
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case 0:
            [self showPictureVC];
            break;
        case 1:
            [self showTakePhotoVC];
            break;
        case 2:
            [self showVoice];
            break;
        case 3:
            [self showPosition];
            break;
            
        default:
            break;
    }
}

- (void)showPictureVC {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.allowsEditing = true;
    imagePC.delegate = self;
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:imagePC animated:true completion:nil];
}

- (void)showTakePhotoVC {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *takePC = [[UIImagePickerController alloc] init];
    takePC.sourceType = UIImagePickerControllerSourceTypeCamera;
    takePC.allowsEditing = true;
    takePC.delegate = self;
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:takePC animated:true completion:nil];
}

- (void)showVoice {
    
}

- (void)showPosition {
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:true completion:nil];
    
    UIImage *imageS = [UIImage imageWithImage:image scaledSize:CGSizeMake(image.size.width, image.size.height)];
    if (self.selectImageDelegate) {
        self.selectImageDelegate(imageS);
    }
}

@end
