import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserController } from './user/user.controller';
import { AuthController } from './auth/auth.controller';
import { AuthService } from './auth/auth.service';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { MemoryController } from './memory/memory.controller';
import { MemoryModule } from './memory/memory.module';
import { MemoryService } from './memory/memory.service';

@Module({
  imports: [
    AuthModule,
    PrismaModule,
    MemoryModule,
  ],
  // controllers: [
  //   AppController,
  //   UserController,
  //   AuthController,
  //   MemoryController,
  // ],
  // providers: [
  //   AppService,
  //   AuthService,
  //   MemoryService,
  // ],
})
export class AppModule {}
