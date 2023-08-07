import {
  Controller,
  Post,
  Body,
  UseInterceptors,
  UploadedFiles,
  UseGuards,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Delete,
} from '@nestjs/common';
import { CreateMemoryDto } from './dtos/create-memory.dto';
import { MemoryService } from './memory.service';
import { FilesInterceptor } from '@nestjs/platform-express';
import { GetUser } from 'src/auth/decorator';
import { JwtAuthGuard } from 'src/auth/guard/jwt-auth.guard';
import { multerConfig } from './multer';

@UseGuards(JwtAuthGuard)
@Controller('memories')
export class MemoryController {
  constructor(
    private readonly memoryService: MemoryService,
  ) {}
  @Post()
  @UseInterceptors(
    FilesInterceptor('images', 5, multerConfig),
  )
  async create(
    @UploadedFiles() files: Express.Multer.File[],
    @GetUser('id') userId: number,
    @Body() createMemoryDto: CreateMemoryDto,
  ) {
    createMemoryDto.images = files.map(
      (file) => file.path,
    );
    return await this.memoryService.create(
      userId,
      createMemoryDto,
    );
  }
  @Get('/:id')
  async findById(
    @Param('id', ParseIntPipe) id: number,
    @GetUser('id') userId: number,
  ) {
    return await this.memoryService.findById(
      id,
      userId,
    );
  }

  @Get()
  async findAll(@GetUser('id') userId: number) {
    return await this.memoryService.findAll(
      userId,
    );
  }

  @Patch('/:id')
  @UseInterceptors(
    FilesInterceptor('images', 5, multerConfig),
  )
  async update(
    @UploadedFiles() files: Express.Multer.File[],
    @Param('id', ParseIntPipe) id: number,
    @GetUser('id') userId: number,
    @Body() dto: CreateMemoryDto,
  ) {
    dto.images = files.map((file) => file.path);
    return await this.memoryService.update(
      id,
      userId,
      dto,
    );
  }

  @Delete('/:id')
  async delete(
    @Param('id', ParseIntPipe) id: number,
    @GetUser('id') userId: number,
  ) {
    return await this.memoryService.delete(
      id,
      userId,
    );
  }
}
