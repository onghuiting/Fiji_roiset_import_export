

% This function generates binary masks from Fiji roiset.zip for time series.
% This function calls "ReadImageJROI.m", downloaded from https://github.com/DylanMuir/ReadImageJROI/blob/master/ReadImageJROI.m
%
% Please make sure your input roiset.zip always follows the sample roiset.zip file, 
% i.e., the naming of each roi, should be: a-b (where a = frame, b = roi_number).
%
% Written by hui ting, 14 March 2022


function bw_tp = roi_to_mask(pathname_roi,filename_roi,img_sz)


[cvsROIs] = ReadImageJROI(fullfile(pathname_roi,filename_roi));
total_roi = length(cvsROIs)

blank = zeros(img_sz,img_sz);
roi_tp=1;
bw_tp{roi_tp} = blank;
prev_tp = 1;

for c_roi=1:total_roi

roi = cvsROIs{c_roi};
pixels = roi.mnCoordinates;
bw_roi = roipoly(blank,pixels(:,1),pixels(:,2));
roi_name = roi.strName

idx = strfind(roi_name,"-");
roi_tp = str2double(roi_name(1:idx-1))

if roi_tp == prev_tp
bw_tp{roi_tp} = bw_tp{roi_tp}+bw_roi;
else
bw_tp{roi_tp} = bw_roi;    
end

prev_tp = roi_tp;

end





