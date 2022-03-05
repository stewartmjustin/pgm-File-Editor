with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with imageprocess; use imageprocess;
with imagepgm; use imagepgm;
procedure Image is
   fileName : unbounded_string;
   fileTemp : imageInfo;
   answer : integer := 0;
   recordExist : integer := 0;
   j, i : integer := 1;

   function getfilename return unbounded_string is
      temp: unbounded_string;
   begin
      Put("Enter The File Name: ");
      get_line(temp);
      return temp;
   end getfilename;
   
begin

   fileTemp.width := -1;
   fileTemp.height := -1;
   fileTemp.maxPixel := -1;
   loop
      exit when j > 500;
      loop
         fileTemp.pixArray(j, i) := -1;
         exit when i = 500;
         i := i + 1;
      end loop;
      j := j + 1;
   end loop;

   loop
      exit when answer = 10;
      case answer is
         when 1 =>
            fileName := getfilename;
            fileTemp := readpgm(fileName);
            put_line("File read successfully");
            recordExist := 1;
         when 2 =>
            if recordExist = 1 then
               fileName := getfilename;
               writepgm(fileTemp, fileName);
               put_line("File written to successfully");
            else
               put_line("No info to write");
            end if;
         when 3 =>
            if recordExist = 1 then
               imageinv(fileTemp);
            else
               put_line("No info to invert");
            end if;
         when 4 =>
            if recordExist = 1 then
               imagestretch(fileTemp);
            else
               put_line("No info to stretch");
            end if;
         when others =>
            answer := 0;
      end case;
      put_line("Menu");
      put_line("1: Read in a .pgm file");
      put_line("2: Write to a .pgm file");
      put_line("3: Image Inversion");
      put_line("4: Image Stretch");
      put_line("10: exit");
      put("Enter Your Choice: ");
      get(answer);
      skip_line;
   end loop;

   put_line("Exiting program...");

   --fileName := getfilename;
   --fileTemp := readpgm(fileName);

   --loop
      --exit when j > fileTemp.height;
      --i := 1;
      --loop
         --exit when i > fileTemp.width;
         --put(fileTemp.pixArray(j, i)'image);
         --i := i + 1;
      --end loop;
      --new_line;
      --j := 1 + j;
   --end loop;

   --put_line("Width: " & fileTemp.width'image & ", height: " & fileTemp.height'image & ", max: " & fileTemp.maxPixel'image);
   --Put_Line(fileName);
   --imageinv;
   --imagestretch;
   --imagelog;
   --readpgm;
   --writepgm;
end Image;