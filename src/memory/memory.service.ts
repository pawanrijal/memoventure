import {
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { CreateMemoryDto } from './dtos/create-memory.dto';
import { Memory } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import * as fs from 'fs';

@Injectable()
export class MemoryService {
  constructor(private prisma: PrismaService) {}

  async create(
    userId: number,
    dto: CreateMemoryDto,
  ): Promise<Memory> {
    const memoryData = {
      location: dto.location,
      date: dto.date, // Convert the date string to a Date object
      description: dto.description,
      tags: dto.tags,
      images: dto.images,
      userId,
    };
    return await this.prisma.memory.create({
      data: memoryData,
    });
  }

  async findById(
    id: number,
    userId: number,
  ): Promise<Memory> {
    const memoryData =
      await this.prisma.memory.findUnique({
        where: { id, userId },
      });

    // check if memory data has data or user has memory
    if (
      !memoryData ||
      memoryData.userId != userId
    )
      throw new ForbiddenException(
        'Access Denied',
      );
    return memoryData;
  }

  async findAll(
    userId: number,
  ): Promise<Memory[]> {
    return await this.prisma.memory.findMany({
      where: { userId },
    });
  }

  async update(
    id: number,
    userId: number,
    payload: CreateMemoryDto,
  ): Promise<Memory> {
    const existingMemory = await this.findById(
      id,
      userId,
    );

    // Delete previous images if needed
    if (
      existingMemory.images &&
      existingMemory.images.length > 0
    ) {
      await this.deleteImages(
        existingMemory.images,
      );
    }

    const memoryData =
      await this.prisma.memory.update({
        where: { id },
        data: { ...payload },
      });

    return memoryData;
  }

  async delete(
    id: number,
    userId: number,
  ): Promise<Memory> {
    const existingMemory = await this.findById(
      id,
      userId,
    );
    if (
      existingMemory.images &&
      existingMemory.images.length > 0
    ) {
      await this.deleteImages(
        existingMemory.images,
      );
    }

    return await this.prisma.memory.delete({
      where: {
        id,
      },
    });
  }

  async deleteImages(
    imageLocations: string[],
  ): Promise<void> {
    // Delete or perform cleanup for each image location
    for (const imageLocation of imageLocations) {
      // Implement image deletion or cleanup
      // For example: fs.unlinkSync(imageLocation);
      fs.unlinkSync(imageLocation);
    }
  }
}
