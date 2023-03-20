--Justin Stewart, stewartm.justin@outlook.com
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

--imagepgm writes to and reads from files
package body imagepgm is

   --reads a fileName to a record and returns the record
   function readpgm(fileName : unbounded_string) return imageInfo is

   magic : unbounded_string;
   fp : file_type;
   fileTemp : imageInfo;
   countW, countH : integer := 1;
   errorInfo : imageInfo;

   begin
      --open the file
      open(fp, in_file, To_String(fileName));

      --collect the magic identifier and check if it is correct
      get_line(fp, magic);
      if magic /= "P2" then
         close(fp);
         errorInfo.maxPixel := -1;
         put_line("File read successfully");
         return errorInfo;
      end if;

      --collect the special numbers and put them in the record
      get(fp, fileTemp.width);
      get(fp, fileTemp.height);
      get(fp, fileTemp.maxPixel);

      --loop to collect the rest of the information in the array
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

      --close the file
      close(fp);

      return fileTemp;
   end readpgm;

   --writes a record to a file
   procedure writepgm(fileTemp : imageInfo; fileName : unbounded_string) is
   fp : file_type;
   i, j : integer := 1;
   begin

      --creates a file to write to
      create(fp, out_file, To_String(fileName));

      --put special numbers and magic identifier in the file
      put_line(fp, "P2");
      put(fp, fileTemp.width'image);
      put_line(fp, fileTemp.height'image);
      put_line(fp, fileTemp.maxPixel'image);

      --loop to put the array into the file
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

      --close the file
      close(fp);
      
   end writepgm;
end imagepgm;