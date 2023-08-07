import {
  IsArray,
  IsNotEmpty,
  IsObject,
  IsOptional,
  IsString,
} from 'class-validator';
import { Type } from 'class-transformer';
export class CreateMemoryDto {
  @IsNotEmpty()
  @IsString()
  location: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsNotEmpty()
  @IsString()
  date: string;

  @IsNotEmpty()
  @IsArray()
  tags: string[];

  @Type(() => File)
  images?: string[];
}
