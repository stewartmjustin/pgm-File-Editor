--Justin Stewart, 1052722, jstewa28@uoguelph.ca
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

--imageprocess deals with modifying images
package body imageprocess is

   --imageinv inverts an image
   procedure imageinv(fileTemp : in out imageInfo) is

   i, j : integer := 1;

   begin

      --loops throught the file and inverts every pixel
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            fileTemp.pixArray(j, i) := fileTemp.maxPixel - fileTemp.pixArray(j, i);

            --flips the sign of negative pixels
            if fileTemp.pixArray(j, i) < 0 then
               fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) * (-1);
            end if;

            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;
   end imageinv;

   --procedure that gets the min and max values from the user
   --used for the imagestretch subprogram
   procedure getMinMax(min : out integer; max : out integer) is
   begin
      put("Enter min: ");
      get(min);
      put_line("");
      put("Enter max: ");
      get(max);
      put_line("");
   end getMinMax;

   --stretches an image
   procedure imagestretch(fileTemp : in out imageInfo) is

   i, j : integer := 1;
   min, max, minMaxDiff : integer;

   begin

      --collects the min and max values from the user
      --checks to see if they are correct and loops otherwise
      loop
         getMinMax(min, max);
         if min < 0 OR min > 255 then
            put_line("Min is not within acceptable range (0 to 255)");
         elsif max < 0 OR max > 255 then
            put_line("Max is not within acceptable range (0 to 255)");
         elsif max < min then
            put_line("Max is less than min");
         elsif max = min then
            put_line("Max is equal to Min, divide by 0");
            return;
         else
            exit;
         end if;
      end loop;

      minMaxDiff := max - min;
      
      i := 1;
      j := 1;

      --loop through the array and stretch every pixel in the immage
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) - min;
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) * 255;
            fileTemp.pixArray(j, i) := fileTemp.pixArray(j, i) / minMaxDiff;
            if fileTemp.pixArray(j, i) < 0 then
               fileTemp.pixArray(j, i) := 0;
            elsif fileTemp.pixArray(j, i) > 255 then
               fileTemp.pixArray(j, i) := 255;
            end if;
            exit when i = fileTemp.width;
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;

      put_line("Image stretched successfully");

   end imagestretch;

   --Applies the Log() function to the image
   procedure imagelog(fileTemp : in out imageInfo) is
      tmp : float;
      i, j : integer := 1;
   begin
      tmp := 255.0/Log(255.0);

      --loops throught and applies Log() to all pixels in the image
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

   --Applies histogram equalisation to an image
   procedure histequal(fileTemp : in out imageInfo) is
      histogram, final : histo;
      pdf, ch : floatHisto;
      i, j : integer := 1;
      totalPixels : integer;
   begin
      --creates a histogram of the image
      histogram := makehist(fileTemp);

      totalPixels := fileTemp.width * fileTemp.height;

      loop
         exit when i > 256;
         pdf(i) := float(histogram(i))/float(totalPixels);
         i := 1 + i;
      end loop;

      i := 2;

      ch(1) := pdf(1);

      loop
         exit when i > 256;
         ch(i) := pdf(i) + ch(i - 1);
         i := i + 1;
      end loop;

      i := 1;

      loop
         exit when i > 256;
         final(i) := integer(ch(i) * 255.0);
         i := i + 1;
      end loop;


      --i := 1;
      --loop
         --exit when i > 256;
         --put_line(i'image & pdf(i)'image);
         --i := i + 1;
      --end loop;

      i := 1;

      --equalizes the image with its histogram
      loop
         exit when j > fileTemp.height;
         i := 1;
         loop
            exit when i > fileTemp.width;
            fileTemp.pixArray(j, i) := final(fileTemp.pixArray(j, i) + 1);
            i := i + 1;
         end loop;
         j := j + 1;
      end loop;


   end histequal;

   --creates and returns the histogram of an image
   function makehist(fileTemp : in imageInfo) return histo is
      j, i : integer := 1;
      histogram : histo;
   begin

   loop
      exit when i > 256;
      histogram(i) := 0;
      i := i + 1;
   end loop;

   loop
      i := 1;
      exit when j > fileTemp.height;
      loop
         exit when i > fileTemp.width;
         histogram(fileTemp.pixArray(j, i) + 1) := histogram(fileTemp.pixArray(j, i) + 1) + 1;
         i := i + 1;
      end loop;
      j := j + 1;
   end loop;

   return histogram;

   end makehist;
end imageprocess;