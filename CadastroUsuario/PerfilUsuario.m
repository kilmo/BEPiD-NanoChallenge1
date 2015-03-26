//
//  PerfilUsuario.m
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PerfilUsuario.h"

@interface PerfilUsuario()

@property (nonatomic,strong) NSString *nomePessoa;


@end

@implementation PerfilUsuario

+(instancetype)inserirUsuario: (NSString*) nomeUsuario{
    PerfilUsuario *pessoa = [[self alloc] init];
    
    pessoa.nomePessoa = nomeUsuario;
    return pessoa;
}




@end
