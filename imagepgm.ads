--Justin Stewart, 1052722, jstewa28@uoguelph.ca
with imageprocess; use imageprocess;
with ada.strings.unbounded; use ada.strings.unbounded;

--declare imagepgm, this package deals with reading from and
--writing to files
package imagepgm is
   function readpgm(fileName : unbounded_string) return imageInfo;
   procedure writepgm(fileTemp : imageInfo; fileName : unbounded_string);
end imagepgm;