//
//  RSTMALLTableViewController.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTMALLTableViewController.h"

#import "RSTMALLData.h"

#import "RSTMALLCell.h"

@interface RSTMALLTableViewController () <UIDynamicAnimatorDelegate>

- (void)__RSInitialize;

@end

@implementation RSTMALLTableViewController

static const NSString *kDefaultCellIdentifierKey   = @"__DEFAULT__";
static const NSString *kDefaultCellIdentifierValue = @"Cell";

#pragma mark - Private

- (void)__RSInitialize
{
    self.flyingDistance = 600.0f;
    self.flyingDurationBase = 0.1;
    self.flyingStep = 0.06;
    self.cellIdentifierMap = [[NSMutableDictionary alloc] init];
    [self.cellIdentifierMap setObject:kDefaultCellIdentifierValue forKey:kDefaultCellIdentifierKey];
    self.dataArray = [[NSMutableArray alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __RSInitialize];
    }
    RSTMALLData *data = [[RSTMALLData alloc] init];
    data.title = @"This is a title";
    data.content = @"This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text.";
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 1; i <= 5; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
    }
    data.images = [NSArray arrayWithArray:images];
    data.countOfRemainingImages = [data.images count];
    [self.dataArray addObject:data];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isViewLoaded = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tableView];
        _animator.delegate = self;
    }
    return _animator;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    id object = self.dataArray[row];
    
    __weak NSString *cellIdentifier = [self.cellIdentifierMap objectForKey:NSStringFromClass([object class])];
    if (!cellIdentifier) {
        cellIdentifier = [self.cellIdentifierMap objectForKey:kDefaultCellIdentifierKey];
    }
    
    id c = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // RSTMALLData -> RSTMALLCell
    if ([object isKindOfClass:[RSTMALLData class]]) {
        RSTMALLData *data = object;
        RSTMALLCell *cell = c;
        cell.titleLabel.text = data.title;
        cell.contentLabel.text = data.content;
        for (int i = 0; i < [data.images count]; i++) {
            RSTMALLImageView *imageView = (RSTMALLImageView *)[self.tableView viewWithTag:(row + 1) * [[self class] imageViewTagOffset] + i];
            if (!imageView) {
                imageView = [[RSTMALLImageView alloc] initWithImage:data.images[i]];
                imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
                imageView.tag = (row + 1) * [[self class] imageViewTagOffset] + i;
                imageView.delegate = self;
                [imageView sizeToFit];
                [self.tableView addSubview:imageView];
            }
            CGRect frame = imageView.frame;
            frame.origin.x = floorf((cell.bounds.size.width - cell.border.bounds.size.width) / 2.0f + cell.border.bounds.size.width - (cell.imagesPlaceHolderWidth + frame.size.width) / 2.0f);
            frame.origin.y = floorf((cell.bounds.size.height - frame.size.height) / 2.0f);
            if (i == 0) {
                frame.origin.x += [[self class] imageViewFrameOffset];
                frame.origin.y += [[self class] imageViewFrameOffset];
            } else if (i >= 2) {
                frame.origin.x -= [[self class] imageViewFrameOffset];
                frame.origin.y -= [[self class] imageViewFrameOffset];
            }
            frame.origin.x += cell.frame.origin.x;
            frame.origin.y += cell.frame.origin.y;
            if (!imageView.isFalling) {
                imageView.frame = frame;
            }
        }
    }
    
    return c;
}

#pragma mark - RSTMALLImageViewDelegate

- (void)didClick:(RSTMALLImageView *)imageView {}

- (void)willFall:(RSTMALLImageView *)imageView
{
    int row = [[[self class] indexPathForImageView:imageView] row];
    
    id object = self.dataArray[row];
    if ([object isKindOfClass:[RSTMALLData class]]) {
        RSTMALLData *data = object;
        data.countOfRemainingImages -= 1;
        if (data.countOfRemainingImages == 0) {
            imageView.isLast = YES;
        }
    }
}

- (void)willReset:(RSTMALLImageView *)imageView
{
    NSIndexPath *indexPath = [[self class] indexPathForImageView:imageView];
    int row = [indexPath row];

    id object = self.dataArray[row];
    if ([object isKindOfClass:[RSTMALLData class]]) {
        RSTMALLData *data = object;
        RSTMALLCell *cell = (RSTMALLCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        data.countOfRemainingImages = [data.images count];
        
        for (int i = 0; i < [data.images count]; i++) {
            RSTMALLImageView *imageView = (RSTMALLImageView *)[self.tableView viewWithTag:(row + 1) * [[self class] imageViewTagOffset] + i];
            [imageView reset];
            CGRect frame = imageView.frame;
            frame.origin.x = floorf((cell.bounds.size.width - cell.border.bounds.size.width) / 2.0f + cell.border.bounds.size.width - (cell.imagesPlaceHolderWidth + frame.size.width) / 2.0f);
            frame.origin.y = floorf((cell.bounds.size.height - frame.size.height) / 2.0f);
            if (i == 0) {
                frame.origin.x += [[self class] imageViewFrameOffset];
                frame.origin.y += [[self class] imageViewFrameOffset];
            } else if (i >= 2) {
                frame.origin.x -= [[self class] imageViewFrameOffset];
                frame.origin.y -= [[self class] imageViewFrameOffset];
            }
            frame.origin.x += cell.frame.origin.x;
            frame.origin.y += cell.frame.origin.y;
            frame.origin.x -= self.flyingDistance;
            imageView.frame = frame;
            
            [UIView animateWithDuration:(self.flyingDurationBase + self.flyingStep * i) delay:self.flyingDurationBase options:UIViewAnimationOptionCurveEaseIn animations:^{
                CGRect frame = imageView.frame;
                frame.origin.x += self.flyingDistance;
                imageView.frame = frame;
            } completion:^(BOOL finished) {
            }];
        }
    }
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator {}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {}

#pragma mark - Public

+ (NSIndexPath *)indexPathForImageView:(RSTMALLImageView *)imageView
{
    int row = imageView.tag / [[self class] imageViewTagOffset] - 1;
    return [NSIndexPath indexPathForRow:row inSection:0];
}

+ (int)indexForImageVIew:(RSTMALLImageView *)imageView
{
    return imageView.tag % [[self class] imageViewTagOffset];
}

+ (NSUInteger)imageViewTagOffset
{
    return 1000;
}

+ (CGFloat)imageViewFrameOffset
{
    return 5.0f;
}

@end
