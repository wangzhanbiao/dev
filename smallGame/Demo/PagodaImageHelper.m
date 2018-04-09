//
//  ImageHelper.m
//  ProxyService
//
//  Created by chenwenhao on 15/10/17.
//  Copyright (c) 2015年 chenwenhao. All rights reserved.
//

#import "PagodaImageHelper.h"
//#import "UIImage+Resize.h"
//#import <ImageIO/ImageIO.h>

static CGFloat const kFillThreshold = 0.45;

@implementation PagodaImageHelper

+ (CGSize)scaledImageSize:(CGSize)imageSize toSize:(CGSize)newSize
{
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    float verticalRadio = newSize.height*1.0/height;
    float horizontalRadio = newSize.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    CGSize scaledSize = CGSizeMake(width, height);
    return scaledSize;
}

+ (CGSize)scaledFromCenterImageSize:(CGSize)imageSize toSize:(CGSize)newSize
{
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    float verticalRadio = newSize.height*1.0/height;
    float horizontalRadio = newSize.width*1.0/width;
    
    float radio = 1;
    
    radio = MAX(verticalRadio, horizontalRadio);
    
    width = width*radio;
    height = height*radio;
    
    CGSize scaledSize = CGSizeMake(width, height);
    return scaledSize;
}

////等比拉伸方法
//+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize resizeMode:(ImageResizeMode)resizeMode
//{
//    if (sourceImage == nil) {
//        return nil;
//    }
//    
//    UIImage *image = nil;
//    
//    if (resizeMode == ImageResizeModeFit) {
//        image = [sourceImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:newSize interpolationQuality:kCGInterpolationHigh];
//    } else if (resizeMode == ImageResizeModeFill) {
//        image = [sourceImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:newSize interpolationQuality:kCGInterpolationHigh];
//    } else if (resizeMode == ImageResizeModeFillCorpCenter) {
//        if (newSize.width >= sourceImage.size.width && newSize.height >= sourceImage.size.height) {
//            image = sourceImage;
//        } else {
//            image = [sourceImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:newSize interpolationQuality:kCGInterpolationHigh];
//            
//            if (newSize.width < image.size.width || newSize.height < image.size.height) {
//                CGRect cropRect = CGRectMake(round((image.size.width - newSize.width) / 2),
//                                             round((image.size.height - newSize.height) / 2),
//                                             newSize.width,
//                                             newSize.height);
//                image = [image croppedImage:cropRect];
//            }
//        }
//    } else {
//        image = sourceImage;
//    }
//    return image;
//}


+ (UIViewContentMode)imageContentModeWithImageSize:(CGSize)imageSize boundSize:(CGSize)boundsSize
{
    UIViewContentMode contentMode = UIViewContentModeScaleAspectFit;
    BOOL isFill = NO;
    
    if ((boundsSize.width > boundsSize.height) && imageSize.width > imageSize.height) {
        double t = ((boundsSize.width / boundsSize.height) - (imageSize.width / imageSize.height));
        if (t > -kFillThreshold && t < kFillThreshold) {
            isFill = YES;
        }
    }else if ((boundsSize.width < boundsSize.height) && imageSize.width < imageSize.height) {
        double t = ((boundsSize.height / boundsSize.width) - (imageSize.height / imageSize.width));
        if (t > -kFillThreshold && t < kFillThreshold) {
            isFill = YES;
        }
    }
    
    if (isFill) {
        contentMode = UIViewContentModeScaleAspectFill;
    }
    return contentMode;
}

+ (UIImage *)clipImageWithTargetRect:(CGRect)clipRect bounds:(CGRect)bounds sourceImage:(UIImage *)originalImage
{
    CGRect rect = clipRect; //rectangle area to be cropped
    float widthFactor = rect.size.width * (originalImage.size.width/bounds.size.width);
    float heightFactor = rect.size.height * (originalImage.size.height/bounds.size.height);
    float factorX = rect.origin.x * (originalImage.size.width/bounds.size.width);
    float factorY = rect.origin.y * (originalImage.size.height/bounds.size.height);
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGRect factoredRect = CGRectMake(factorX,factorY*scale,widthFactor*scale,heightFactor*scale);
    CGImageRef tmp = CGImageCreateWithImageInRect([originalImage CGImage], factoredRect);
    UIImage *cropImage = [UIImage imageWithCGImage:tmp];
    CGImageRelease(tmp);
    tmp = nil;
    return cropImage;
}

+ (UIImage *)overlayImageWithTargetRect:(CGRect)overlayRect overlayImage:(UIImage *)overlayImage originalImage:(UIImage *)originalImage {
    if (overlayImage == nil) {
        return originalImage;
    }
    
    CGSize scaleSize = [self scaledImageSize:overlayImage.size toSize:overlayRect.size];
    
    CGFloat x = (overlayRect.size.width - ceil(scaleSize.width)) / 2 + overlayRect.origin.x;
    
    CGFloat y = (overlayRect.size.height - ceil(scaleSize.height)) / 2 + overlayRect.origin.y;
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
    
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    
    [overlayImage drawInRect:CGRectMake(x, y, scaleSize.width, scaleSize.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds
{
    CGRect rect=CGRectMake(0.0f, 0.0f, bounds.size.width, bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
