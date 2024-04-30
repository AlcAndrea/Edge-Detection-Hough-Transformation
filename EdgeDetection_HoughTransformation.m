clear all
clc

I = imread('road.jpg');
iGray = rgb2gray(I);

% imshow(iGray);

% apply the Hough transform with a threshold value in the Canny
% edge detector of 0.4

iBW = edge(iGray,'canny', 0.4);
% imshow(iBW)

% hough transform
[H,T,R] = hough(iBW); % Creates the matrix size for H, T, R

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));

lines = houghlines(iBW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(iGray), hold on
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','Green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','Red');