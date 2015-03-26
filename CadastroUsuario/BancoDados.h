//
//  BancoDados.h
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PerfilUsuario;


@interface BancoDados : NSObject

@property (nonatomic, readonly) NSArray *listaNomes;

+(instancetype) sharedStore; //permite ter somente uma instancia desse objeto


-(PerfilUsuario *) criaUsuario: (NSString*)nomeUsuario;


@end
