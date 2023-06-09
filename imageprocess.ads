--Justin Stewart, stewartm.justin@outlook.com

--imageprocess is a package that processes images
--and transforms them in a variety of ways at the users behest
package imageprocess is
   type matrix is array(1..500, 1..500) of integer;
   type histo is array(1..256) of integer;
   type floatHisto is array(1..256) of float;
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
   procedure getMinMax(min : out integer; max : out integer);
   procedure histequal(fileTemp : in out imageInfo);
   function makehist(fileTemp : in imageInfo) return histo;
end imageprocess;