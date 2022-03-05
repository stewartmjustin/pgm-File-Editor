package imageprocess is
   type matrix is array(1..500, 1..500) of integer;
   type imageInfo is
      record
         width: integer;
         height: integer;
         maxPixel: integer;
         pixArray: matrix;
      end record;
   procedure imageinv(fileTemp : in out imageInfo);
   procedure imagelog(fileTemp : in out imageInfo);
   procedure imagestretch(fileTemp : in out imageInfo);
end imageprocess;