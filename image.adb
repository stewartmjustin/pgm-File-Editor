--Justin Stewart, 1052722, jstewa28@uoguelph.ca
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with imageprocess; use imageprocess;
with imagepgm; use imagepgm;

--Image serves as the main of the program, allows the user to select which subprogram to call
procedure Image is
   --Declaring variables

   fileName : unbounded_string;
   fileTemp : imageInfo;
   answer : integer := 0;
   recordExist : integer := 0;
   j, i : integer := 1;

   --Function retrieves a file name from the user for file I/O
   function getfilename return unbounded_string is
      --Declaring variables
      temp: unbounded_string;
   begin
      Put("Enter The File Name: ");
      get_line(temp);
      return temp;
   end getfilename;
   
begin
   --initialize the record
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

   --loops through the options of the menu, allowing the user
   --to select the subprogram they would like
   loop
      exit when answer = 7;
      case answer is

         --case 1 is for retreving image info from a file
         when 1 =>
            fileName := getfilename;
            fileTemp := readpgm(fileName);
            if fileTemp.maxPixel = -1 then
               put_line("Magic indentifier incorrect");
            else
               recordExist := 1;
               put_line("File read successfully");
            end if;

         --case 2 is for writing image info to a file
         when 2 =>
            if recordExist = 1 then
               fileName := getfilename;
               writepgm(fileTemp, fileName);
               put_line("File written to successfully");
            else
               put_line("No info to write");
            end if;

         --case 3 is for inverting an image
         when 3 =>
            if recordExist = 1 then
               imageinv(fileTemp);
               put_line("Image inverted successfully");
            else
               put_line("No info to invert");
            end if;

         --case 4 is for stretching an image
         when 4 =>
            if recordExist = 1 then
               imagestretch(fileTemp);
            else
               put_line("No info to stretch");
            end if;

         --case 5 is for applying Log() to the image
         when 5 =>
            if recordExist = 1 then
               imagelog(fileTemp);
               put_line("Log() applied to image successfully");
            else
               put_line("No info to Log()");
            end if;

         --case 6 is for applying histogram equilization to the image
         when 6 =>
            if recordExist = 1 then
               histequal(fileTemp);
               put_line("Image equalized successfully");
            else
               put_line("No info to Equalize");
            end if;

         when others =>
            put_line("Not an acceptable answer:" & answer'image);
            answer := 0;
      end case;

      --The following is the menu for selecting what the program should do
      put_line("");
      put_line("Menu");
      put_line("1: Read in a .pgm file");
      put_line("2: Write to a .pgm file");
      put_line("3: Image Inversion");
      put_line("4: Image Stretch");
      put_line("5: Image Log");
      put_line("6: Histogram Equalization");
      put_line("7: exit");
      put("Enter Your Choice: ");
      get(answer);
      skip_line;
      put_line("");
   end loop;

   put_line("Exiting program...");

end Image;