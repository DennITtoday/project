 import { Get, Module } from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { PostService } from "./post.service";

import { PrismaService } from "./prisma.service";
import { UsersModule } from './users/users.module';
imports:[
    ConfigModule.forRoot({

envFilePath: '.env'

    })
]
 @Module({
controllers: [],
 imports: [UsersModule,PostService]

        })
        export class AppModule { }
