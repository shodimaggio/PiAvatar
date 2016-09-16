function axl = l3dxyzread(l3d)
rwBit   = hex2dec('80'); % 読込み
msBit   = hex2dec('40'); % 連続読込み
adOutXl = hex2dec('28');
spiCom  = bitor(rwBit, msBit,  'uint8');
spiCom  = bitor(spiCom,adOutXl,'uint8');
spiCom  = [ spiCom repmat(hex2dec('00'),1,12) ];
dat     = l3d.writeRead(spiCom);
xl = dat(3);
xh = dat(5);
x = convdata_(xh,xl); % X方向データ
yl = dat(7);
yh = dat(9);
y = convdata_(yh,yl); % Y方向データ
zl = dat(11);
zh = dat(13);
z = convdata_(zh,zl); % Z方向データ
axl = double([ x y z ])/(16*1024); % 重力加速度で正規化

function out = convdata_(high,low) % ２の補数表現変換
out = int32(bitshift(uint16(high),8)+uint16(low));
if bitand(high,hex2dec('80'))
    out = out - 2*hex2dec('8000'); % 負値への変換
end
