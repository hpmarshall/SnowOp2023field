% load and plot snow depths
S1={'20230130','20230131','20230201','20230202'}
S2={'20230221','20230223'}

% get all survey1 depths
S1depths=[]; S1lat=[]; S1lon=[];
for n=1:length(S1)
    Dlist=dir(['DEPTHS/' S1{n} '/*.xlsx'])
    for q=1:length(Dlist)
        D=readtable(['DEPTHS/' S1{n} '/' Dlist(q).name]);
        S1depths=[S1depths; D.Depth];
        S1lat=[S1lat; D.Latitude];
        S1lon=[S1lon; D.Longitude];
    end
end
[S1E,S1N,Zone]=ll2utm(S1lat,S1lon);

% get all survey2 depths
S2depths=[]; S2lat=[]; S2lon=[];
for n=1:length(S2)
    Dlist=dir(['DEPTHS/' S2{n} '/*.xlsx'])
    for q=1:length(Dlist)
        D=readtable(['DEPTHS/' S2{n} '/' Dlist(q).name]);
        S2depths=[S2depths; D.Depth];
        S2lat=[S2lat; D.Latitude];
        S2lon=[S2lon; D.Longitude];
    end
end
[S2E,S2N,Zone]=ll2utm(S2lat,S2lon);

%% lets plot histograms of both
figure(4);clf
subplot(2,2,1)
hist(S1depths,50)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
axis([75 275 0 250])
hold on
plot([median(S1depths) median(S1depths)],[0 250],'r','linewidth',2)
title('SURVEY #1')
xlabel('depth [cm]')
subplot(2,2,3)
hist(S2depths,50)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
axis([75 275 0 175])
hold on
plot([median(S2depths) median(S2depths)],[0 175],'r','linewidth',2)
title('SURVEY #2')
xlabel('depth [cm]')
subplot(2,2,[2 4])
G=ones(size(S1depths));
G2=2*ones(size(S2depths));
Gall=[G;G2];  Dall=[S1depths;S2depths];
L={'Jan 30-Feb 2','Feb 21-23'};
h=boxplot(Dall,Gall,'notch','on','Labels',L); grid on
set(h,'linewidth',2)
ylabel('depth [cm]')
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')




