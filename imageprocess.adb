with Ada.Text_IO; use Ada.Text_IO;

package body imageprocess is
   procedure imageinv(fileTemp : in out imageInfo) is

   i, j : integer := 1;

   begin
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            fileTemp.pixArray(j, i) := fileTemp.maxPixel - fileTemp.pixArray(j, i);
            if fileTemp.pixArray(j, i) < 0 then
               fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) * (-1);
            end if;
            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;
   end imageinv;

   procedure imagestretch(fileTemp : in out imageInfo) is

   i, j : integer := 1;
   min, max, minMaxDiff : integer;

   begin
      max := fileTemp.pixArray(1, 1);
      min := fileTemp.pixArray(1, 1);
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            if (fileTemp.pixArray(j, i) > max) then
               max := fileTemp.pixArray(j, i);
            end if;
            if (fileTemp.pixArray(j, i) < min) then
               min := fileTemp.pixArray(j, i);
            end if;
            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;

      minMaxDiff := max - min;

      put_line(min'image);
      put_line(max'image);
      put_line(minMaxDiff'image);
      
      i := 1;
      j := 1;

      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            --fileTemp.pixArray(j, i) := 255 * ((fileTemp.pixArray(j, i) - min) / max - min);
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) - min;
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) * 255;
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) / minMaxDiff;
            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;

   end imagestretch;

   procedure imagelog(fileTemp : in out imageInfo) is
   begin
      put_line("imageLog");
   end imagelog;
end imageprocess;