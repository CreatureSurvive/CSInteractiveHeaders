# CSInteractiveHeaders

A dead simple implementation of interactive (stretchable) header images that can easily be added to any UIScrollView, UITableView, UICollectionView, etc. This includes a navigation category to interactivly control the navigation bar transparency with the scroll view.

![demo](Assets/demo.gif)

## Implementation

#### Implementing Interactive Headers

Import the category:

`#import "UIScrollView+InteractiveHeader.h"`

In your ViewController:

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.tableView addHeaderWithImage:[UIImage imageNamed:@"banner.jpg"] height:300];
    [self.tableView.interactiveHeader setUseAlphaFade:YES];
    [self.tableView.interactiveHeader setLabelOffset:22];
    [self.tableView.interactiveHeader.titleLabel setText:@"A Clever Title"];
    [self.tableView.interactiveHeader.subtitleLabel setText:@"Some Sub-text"];
}
```



#### Implementing Interactive Navigation Bars

Import the category:

`#import "UINavigationBar+InteractiveHeader.h"`

In your ViewController:

```objective-c
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setScrollView:self.tableView];
    [self.navigationController.navigationBar setScrollTintColor:UIColor.darkTextColor];
}
```



thats it, your done.



# Author

Dana Buehre (CreatureSurvive)
[cs@creaturecoding.com](mailto:cs@creaturecoding.com)

© Dana Buehre (CreatureSurvive) 2020