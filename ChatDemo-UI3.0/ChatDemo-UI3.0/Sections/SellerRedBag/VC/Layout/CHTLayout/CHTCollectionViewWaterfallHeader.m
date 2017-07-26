//
//  CHTCollectionViewWaterfallHeader.m
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"

@implementation CHTCollectionViewWaterfallHeader

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}


- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.frame;
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;

}

@end
