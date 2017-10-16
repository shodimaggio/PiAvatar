cam = webcam(1);
%preview(cam);
fcd = vision.CascadeObjectDetector(); % 'antDetector.xml')
img = snapshot(cam);
bboxes = fcd.step(img);
img = insertObjectAnnotation(img, 'rectangle', bboxes, 'Face');
imshow(img)
clear cam