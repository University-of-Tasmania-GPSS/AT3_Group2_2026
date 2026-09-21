function [data, file, fdir]=chkload(fname,ext);

% CHKLOAD checks the existence of a file and loads it
%	[data, file, fdir]=chkload(fname,ext) checks the existence of fname and loads it.
%	If ext is specified, it will be used as a file extension. The optional output file
%	is the file name without extension, and fdir is the source directory of the file.
%	If the file does not exist an empty data matrix will be returned, and a warning
%	displayed. 
%
%	Martin Truffer, December 2000

if nargin==2
   lext=length(ext);
   if ext(1)=='.'
      ext=ext(2:lext);
   end
end

fn=length(fname);
if or(fn<5,fname(fn-3)~='.');
   file=fname;
   fname=[fname '.' ext];
else
   file=fname(1:fn-4);
end
fn=length(fname);

[fid,message] = fopen(fname, 'r');
if fid == -1
   warning([fname ': ' message]);
   data=[];
   fdir=[];
else
   status=fclose(fid);
	fdir=which(fname);
	fnd=length(fdir);
	fdir=fdir(1:fnd-fn);
   data=load(fname);
end
