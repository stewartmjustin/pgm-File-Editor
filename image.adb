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
            if fileTemp.maxPixel = -1 then
               put_line("Magic indentifier incorrect");
            else
               recordExist := 1;
               put_line("File read successfully");
            end if;
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
               put_line("file inverted successfully");
            else
               put_line("No info to invert");
            end if;
         when 4 =>
            if recordExist = 1 then
               imagestretch(fileTemp);
               put_line("File stretched successfully");
            else
               put_line("No info to stretch");
            end if;
         when 5 =>
            if recordExist = 1 then
               imagelog(fileTemp);
               put_line("Log() applied to file successfully");
            else
               put_line("No info to Log()");
            end if;
         when others =>
            put_line("Not an acceptable answer:" & answer'image);
            answer := 0;
      end case;
      put_line("");
      put_line("Menu");
      put_line("1: Read in a .pgm file");
      put_line("2: Write to a .pgm file");
      put_line("3: Image Inversion");
      put_line("4: Image Stretch");
      put_line("5: Image Log");
      put_line("10: exit");
      put("Enter Your Choice: ");
      get(answer);
      skip_line;
      put_line("");
   end loop;

   put_line("Exiting program...");

end Image;