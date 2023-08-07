import { IsInt, IsString } from 'class-validator';
import { Type } from 'class-transformer';

export class ImageUploadDTO {
  @IsInt()
  userId: number;

  @IsString()
  location: string;

  @IsString()
  date: string;

  @IsString()
  description: string;

  @Type(() => File)
  file: File;
}
