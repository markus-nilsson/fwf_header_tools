function GWF = fwf_bin2gwf_siemens(bin_fn)
% function GWF = fwf_bin2gwf_siemens(bin_fn)
% By Filip Sz

fileID = fopen(bin_fn, 'r');

% Read meta data
% ver = fread(fileID, 1, 'single');
n_U = fread(fileID, 1, 'int32');
n_A = fread(fileID, 1, 'int32');
n_B = fread(fileID, 1, 'int32');

% Read waveforms
gn_A(:,1) = fread(fileID, n_A*n_U, 'single');
gn_A(:,2) = fread(fileID, n_A*n_U, 'single');
gn_A(:,3) = fread(fileID, n_A*n_U, 'single');
gn_B(:,1) = fread(fileID, n_B*n_U, 'single');
gn_B(:,2) = fread(fileID, n_B*n_U, 'single');
gn_B(:,3) = fread(fileID, n_B*n_U, 'single');

% sha = fread(fileID, 64, 'uint8');

fclose(fileID);

% Organize waveforms
gn_A = permute(reshape(gn_A, n_A, n_U, 3), [1 3 2]);
gn_B = permute(reshape(gn_B, n_B, n_U, 3), [1 3 2]);

GWF = cell(2,n_U);
for c = 1:n_U
    GWF{1,c} = gn_A(:,:,c);
    GWF{2,c} = gn_B(:,:,c);
end
