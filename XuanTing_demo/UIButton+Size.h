//
//  UIButton+Size.h
//  XuanTing_demo
//
//  Created by YinlongNie on 17/1/12.
//  Copyright © 2017年 Jiuzhekan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Size)

/**
 *  通过字体来设置button的frame
 *
 *  @param width    宽
 *  @param fontSize 字体大小
 *  @param str      title
 *
 *  @return <#return value description#>
 */
+(CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str;



@end
