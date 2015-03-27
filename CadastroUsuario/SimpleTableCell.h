//
//  SimpleTableCell.h
//  CadastroUsuario
//
//  Created by Felipe R. de Luca on 3/27/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;


@end
