camList = webcamlist
cam = webcam(1)
%preview(cam);
img = snapshot(cam);
image(img);
for idx = 1:5
    img = snapshot(cam);
    imshow(img)
    pause()
    imwrite(img,sprintf('tmp%03d.jpg',idx));
end
clear cam

