
F = getframe(handles.axes1);
Image = frame2im(F);
imwrite(Image, 'Image.jpg')