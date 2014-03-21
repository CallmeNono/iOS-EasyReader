//
//  CSCollectionPageControl.m
//  EasyReader
//
//  Created by Alfredo Uribe on 3/21/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import "CSCollectionPageControl.h"
#import "CSFeedItemCollectionViewDataSource.h"
#import "CSHomeViewController.h"

@implementation CSCollectionPageControl
{
  float leftFadeOrigin;
  float rightFadeOrigin;
  float gradientWidth;
  float fadeMovement;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    UIButton *dot = [UIButton buttonWithType:UIButtonTypeInfoLight];
    dot.frame = CGRectMake(10,(self.frame.size.height/2)-5, 12, 12);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newItemButton:)];
    [dot addGestureRecognizer:singleTap];
    
    [self addSubview:dot];
  }
  return self;
}

-(void)newItemButton:(id)sender
{
  CSFeedItemCollectionViewDataSource *dataSource = [_controller_owner feedCollectionViewDataSource];
  [_controller_owner setCurrentFeedItem:[[dataSource sortedFeedItems] firstObject]];
  [_controller_owner scrollToCurrentFeedItem];
  _controller_owner.collectionCellGoingTo = 0;
  [self setPageControllerPageAtIndex:[[dataSource sortedFeedItems]indexOfObject:_controller_owner.currentFeedItem]
                       forCollection:_controller_owner.feedItems];
}

-(void)setUpFadesOnView:(UIView*)mask
{
  _view_maskLayer = [[UIView alloc] init];
  gradientWidth = 40;
  fadeMovement = 10;
  
  _view_leftFade = [[UIView alloc] init];
  _view_leftFade.frame = CGRectMake(110, 10, gradientWidth, 20);
  leftFadeOrigin = 110;
  _view_leftFade.backgroundColor = [UIColor blackColor];
  
  CAGradientLayer *leftLayer = [CAGradientLayer layer];
  leftLayer.frame = _view_leftFade.bounds;
  leftLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
  leftLayer.startPoint = CGPointMake(0.0f, 1.0f);
  leftLayer.endPoint = CGPointMake(1.0f, 1.0f);
  _view_leftFade.layer.mask = leftLayer;
  
  _view_rightFade = [[UIView alloc] init];
  _view_rightFade.frame = CGRectMake(170, 10, gradientWidth, 20);
  rightFadeOrigin = 170;
  _view_rightFade.backgroundColor = [UIColor blackColor];
  
  CAGradientLayer *rightLayer = [CAGradientLayer layer];
  rightLayer.frame = _view_rightFade.bounds;
  rightLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
  rightLayer.startPoint = CGPointMake(1.0f, 1.0f);
  rightLayer.endPoint = CGPointMake(0.0f, 1.0f);
  _view_rightFade.layer.mask = rightLayer;
  
  [_view_maskLayer addSubview:_view_leftFade];
  [_view_maskLayer addSubview:_view_rightFade];
  [mask addSubview:_view_maskLayer];
}

- (void)setPageControllerPageAtIndex:(NSInteger)index forCollection:(NSSet*)collection
{
  if ([collection count] < 6){
    self.currentPage = index;
  } else {
    if( index < 2 ){
      self.currentPage = index;
      [UIView animateWithDuration:.75 animations:^{
        _view_leftFade.frame = CGRectMake(leftFadeOrigin-(fadeMovement*(2-index)), 10, gradientWidth, 20);
      }];
    } else if(index > ([collection count]-3) ){
      self.currentPage = 5-([collection count]-index);
      [UIView animateWithDuration:.75 animations:^{
        _view_rightFade.frame = CGRectMake(rightFadeOrigin+(fadeMovement*(3-([collection count]-index))), 10, gradientWidth, 20);
      }];
    } else {
      self.currentPage = 2;
      [UIView animateWithDuration:.75 animations:^{
        _view_leftFade.frame = CGRectMake(leftFadeOrigin, 10, gradientWidth, 20);
        _view_rightFade.frame = CGRectMake(rightFadeOrigin, 10, gradientWidth, 20);
      }];
    }
  }
}

@end
