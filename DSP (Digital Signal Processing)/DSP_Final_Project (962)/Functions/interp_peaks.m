function [iploc, ipmag, ipphase] = interp_peaks(mX, pX, ploc)
% Parabolic interpolation of spectral peaks
% mX: magnitude spectrum
% pX: phase spectrum
% ploc: locations of peaks
% iploc, ipmag, ipphase: interpolated values
% note that ploc values are assumed to be between 2 and length(mX)-1
val = mX(ploc); % magnitude of peak bin
lval = mX(ploc-1); % magnitude of bin at left
rval= mX(ploc+1); % magnitude of bin at right
iploc = ploc + .5*(lval-rval)./(lval-2*val+rval); % center of parabola
ipmag = val-.25*(lval-rval).*(iploc-ploc); % magnitude of peaks
ipphase = interp1(1:length(pX),pX,iploc,'linear'); % phase of peaks