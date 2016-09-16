function axl = l3dxyzread(l3d)
rwBit   = hex2dec('80'); % �Ǎ���
msBit   = hex2dec('40'); % �A���Ǎ���
adOutXl = hex2dec('28');
spiCom  = bitor(rwBit, msBit,  'uint8');
spiCom  = bitor(spiCom,adOutXl,'uint8');
spiCom  = [ spiCom repmat(hex2dec('00'),1,12) ];
dat     = l3d.writeRead(spiCom);
xl = dat(3);
xh = dat(5);
x = convdata_(xh,xl); % X�����f�[�^
yl = dat(7);
yh = dat(9);
y = convdata_(yh,yl); % Y�����f�[�^
zl = dat(11);
zh = dat(13);
z = convdata_(zh,zl); % Z�����f�[�^
axl = double([ x y z ])/(16*1024); % �d�͉����x�Ő��K��

function out = convdata_(high,low) % �Q�̕␔�\���ϊ�
out = int32(bitshift(uint16(high),8)+uint16(low));
if bitand(high,hex2dec('80'))
    out = out - 2*hex2dec('8000'); % ���l�ւ̕ϊ�
end
