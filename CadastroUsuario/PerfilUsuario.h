//
//  PerfilUsuario.h
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerfilUsuario : NSObject

@property (nonatomic,strong) NSString *nomePessoa;
@property (nonatomic,strong) NSString *fotoPessoa;
@property (nonatomic,strong) NSDate *dataNascimento;
@property (nonatomic) long int id_digital;

@end
