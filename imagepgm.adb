with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

package body imagepgm is

   function readpgm(fileName : unbounded_string) return imageInfo is

   magic : unbounded_string;
   fp : file_type;
   fileTemp : imageInfo;
   countW, countH : integer := 1;

   begin
      open(fp, in_file, To_String(fileName));
      get_line(fp, magic);
      get(fp, fileTemp.width);
      get(fp, fileTemp.height);
      get(fp, fileTemp.maxPixel);
      loop
         exit when end_of_file(fp);
         exit when countH > fileTemp.height;
         get(fp, fileTemp.pixArray(countH, countW));
         exit when countH = fileTemp.height AND countW = fileTemp.width;
         countW := countW + 1;
         if countW > fileTemp.width then
            countH := countH + 1;
            countW := 1;
         end if;
      end loop;
      close(fp);
      return fileTemp;
   end readpgm;

   procedure writepgm(fileTemp : imageInfo; fileName : unbounded_string) is
   fp : file_type;
   i, j : integer := 1;
   begin
      create(fp, out_file, To_String(fileName));
      put_line(fp, "P2");
      put(fp, fileTemp.width'image);
      put_line(fp, fileTemp.height'image);
      put_line(fp, fileTemp.maxPixel'image);
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            put(fp, fileTemp.pixArray(j, i)'image);
            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         put_line(fp, "");
         j := j + 1;
      end loop;
      close(fp);
   end writepgm;
end imagepgm;