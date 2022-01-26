% Main Program Starts here
function result = SaveFace(path_)
	img_ = imread(path_);
	img = rgb2gray(img_);

	faceDetector =  vision.CascadeObjectDetector;
	faceDetector.MergeThreshold = 7;

	Boundingboxes = faceDetector(img);
	

	%if ~isempty(Boundingboxes)
	%    Imf = insertObjectAnnotation(img,'rectangle',Boundingboxes,'Faces','linewidth',3);
	%    imshow(Imf);
	%    title('detected faces');
	%else
	%    position = [0 0];
	%    label='no face detected';
	%    Imgn = insertText(img,position,label, 'fontsize',25,'BoxOpacity',1);
	%    imshow(Imgn);
	%end
	
	
	for i = 1 : size(Boundingboxes, 1) 
	  J = imcrop(img_, Boundingboxes(i, :)); 
	  name = strcat('/MATLAB Drive/DSP/attended/', num2str(i),'.png');
	  imwrite(J,name); 
	end
	result = i;
end