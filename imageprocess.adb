with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

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

   procedure getMinMax(min : out integer; max : out integer) is
   begin
      put("Enter min: ");
      get(min);
      put_line("");
      put("Enter max: ");
      get(max);
      put_line("");
   end getMinMax;

   procedure imagestretch(fileTemp : in out imageInfo) is

   i, j : integer := 1;
   min, max, minMaxDiff : integer;

   begin
      getMinMax(min, max);

      minMaxDiff := max - min;
      
      i := 1;
      j := 1;

      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
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
      tmp : float;
      i, j : integer := 1;
   begin
      tmp := 255.0/Log(255.0);
      loop
         exit when j > fileTemp.height;
         loop
            exit when i > fileTemp.width;
            fileTemp.pixArray(j, i) := integer(Log(float(fileTemp.pixArray(j, i) + 1)) * tmp);
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;
   end imagelog;
end imageprocess;