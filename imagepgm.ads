--Justin Stewart, 1052722, jstewa28@uoguelph.ca
with imageprocess; use imageprocess;
with ada.strings.unbounded; use ada.strings.unbounded;

package imagepgm is
   function readpgm(fileName : unbounded_string) return imageInfo;
   procedure writepgm(fileTemp : imageInfo; fileName : unbounded_string);
end imagepgm;