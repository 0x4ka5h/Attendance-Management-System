

clc;
close all;
system("rm -f /'MATLAB Drive'/DSP/attended/*.png");
x = input("want reset? (1/0): ");
if (x)
    keySet = {'n170001','n170002','n170005','n170006','n170011','n170031','n170054','n170403','n170405','n170414','n170432','n170634','n170713','n170034'};
    value={0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    attendance_Data = containers.Map(keySet,value);
    save data attendance_Data;
end

image_path = "day_2.png";
count = SaveFace(image_path);

dataDir = fullfile('/MATLAB Drive/DSP/strength');
presentdataDir = fullfile('/MATLAB Drive/DSP/attended');
full_students = imageDatastore(dataDir);
thumbnailGallery = [];
for i = 1:length(full_students.Files)
    I = readimage(full_students,i);
    thumbnail = imresize(I,[300 300]);
    thumbnailGallery = cat(4,thumbnailGallery,thumbnail);
end


attended_students = imageDatastore(presentdataDir);
thumbnailGalleryPresentData = [];
for i = 1:length(attended_students.Files)
    I = readimage(attended_students,i);
    thumbnail = imresize(I,[300 300]);
    thumbnailGallery = cat(4,thumbnailGalleryPresentData,thumbnail);
end

imageIndex = indexImages(full_students);


queryDir='/MATLAB Drive/DSP/attended/';
attended_students = imageDatastore(queryDir);

clc;
load data;

for i = 1:length(attended_students.Files)
    queryImage = imread([queryDir strcat(num2str(i),'.png')]);
    imageIDs = retrieveImages(queryImage,imageIndex);
    bestMatch = imageIDs(1);

    bestImage = imread(imageIndex.ImageLocation{bestMatch});
    location=imageIndex.ImageLocation{bestMatch};
    %figure
    %imshowpair(queryImage,bestImage,'montage');
    id=split(location,'/');
    id=id(5);
    id = split(id,'.');
    disp(strcat(id(1)," presented"));
    attendance_Data(strcat(id(1),"")) = attendance_Data(strcat(id(1),"")) + 1;
end
disp(keys(attendance_Data));
disp(values(attendance_Data));
save data attendance_Data;