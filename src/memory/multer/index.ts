import { diskStorage } from 'multer';
import { extname } from 'path';

export const multerConfig = {
  storage: diskStorage({
    destination: (req, file, cb) => {
      cb(null, 'uploads/memories/'); // Set the destination folder for uploaded images
    },
    filename: (req, file, cb) => {
      const randomName = Array(32)
        .fill(null)
        .map(() =>
          Math.round(Math.random() * 16).toString(
            16,
          ),
        )
        .join('');
      cb(
        null,
        `${randomName}${extname(
          file.originalname,
        )}`,
      );
    },
  }),
};
