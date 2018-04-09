//
//  ImageHelper.h
//  ProxyService
//
//  Created by chenwenhao on 15/10/17.
//  Copyright (c) 2015年 chenwenhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageResizeMode)
{
    ImageResizeModeFit = 0,
    ImageResizeModeFill = 1,
    ImageResizeModeFillCorpCenter = 2
};


@interface PagodaImageHelper : NSObject

+ (UIViewContentMode)imageContentModeWithImageSize:(CGSize)imageSize boundSize:(CGSize)boundsSize;

+ (UIImage *)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize resizeMode:(ImageResizeMode)resizeMode;

+ (CGSize)scaledImageSize:(CGSize)imageSize toSize:(CGSize)newSize;

+ (CGSize)scaledFromCenterImageSize:(CGSize)imageSize toSize:(CGSize)newSize;

+ (UIImage *)clipImageWithTargetRect:(CGRect)clipRect bounds:(CGRect)bounds sourceImage:(UIImage *)originalImage;

+ (UIImage *)overlayImageWithTargetRect:(CGRect)overlayRect overlayImage:(UIImage *)overlayImage originalImage:(UIImage *)originalImage;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds;

@end
