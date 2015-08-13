% using popular mha_read_header & mha_read_volume to read a .mha simply and
% to modularise it
function IMAGE = read_mha(file_path)
addpath('readMHA');
HEADER = mha_read_header(file_path);
IMAGE = mha_read_volume(HEADER);