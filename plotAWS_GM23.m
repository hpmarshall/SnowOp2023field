% plotAWS_GM23
% load and plot data from Grand Mesa Study Plot - Skyway and Mesa Lakes
% SNOTEL

D=readtable('MesaLakesSNOTEL_WY23.csv')
%%
h=figure(1); clf
depth=D.SNWD_I_1_in_*2.54; % snow depth [cm]
depth(depth<0)=NaN;
tSWE=D.WTEQ_I_1_in_*2.54; % SWE [cm]
tSWE(tSWE<0)=NaN;
for n=1:length(tSWE)
    mydate(n)=datetime([datestr(D.Date(n)) ' ' D.Time{n}]);
end

t1A=datetime(2023,1,30);
t1B=datetime(2023,2,2);
t2A=datetime(2023,2,21);
t2B=datetime(2023,2,23);

subplot(2,4,1:2)
fill([t1A t1B t1B t1A t1A],[0 0 max(depth)*1.1 max(depth)*1.1 0],[0.7 0.7 0.7])
hold on
fill([t2A t2B t2B t2A t2A],[0 0 max(depth)*1.1 max(depth)*1.1 0],[0.7 0.7 0.7])
plot(mydate,depth,'x-','linewidth',2)
xlim([t1A-caldays(1) t2B+caldays(1)])
ylim([125 160])
grid on
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
xlabel('date'); ylabel('depth [cm]')

subplot(2,4,5:6)
fill([t1A t1B t1B t1A t1A],[0 0 max(tSWE)*1.1 max(tSWE)*1.1 0],[0.7 0.7 0.7])
hold on
fill([t2A t2B t2B t2A t2A],[0 0 max(tSWE)*1.1 max(tSWE)*1.1 0],[0.7 0.7 0.7])
plot(mydate,tSWE,'ro','linewidth',2)
xlim([t1A-caldays(1) t2B+caldays(1)])
ylim([31 39])
grid on
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
xlabel('date'); ylabel('SWE [cm]')



%%
Survey1=readtable('PitsFedSamplers.xlsx','Sheet','Survey1-pits');
Survey2pits=readtable('PitsFedSamplers.xlsx','Sheet','Survey2-pits');
Survey2Fs=readtable('PitsFedSamplers.xlsx','Sheet','Survey2-Fs');
H=Survey1.HS1;
SWE=Survey1.SWE1;
for n=1:length(Survey2pits.HS2)
    H2(n,1)=str2num(Survey2pits.HS2{n});
    SWE2(n,1)=str2num(Survey2pits.SWE2{n});
end
H3=Survey2Fs.FsHS2;
SWE3=Survey2Fs.FsSWE2;
G=ones(size(H));
G2=2*ones(size(H2));
G3=2*ones(size(H3));
Hall=[H;H2;H3];
SWEall=[SWE;SWE2;SWE3]
Gall=[G;G2;G3];
subplot(2,4,3)
L={'Jan 30-Feb 2','Feb 21-23'};
h=boxplot(Hall,Gall,'notch','on','Labels',L); grid on
ylabel('depth [cm]')

set(h,'linewidth',2)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
subplot(2,4,7)
h=boxplot(SWEall,Gall,'notch','on','Labels',L); grid on
set(h,'linewidth',2)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
ylabel('SWE [cm]')

%% find coincident differences
Ix=isfinite(SWE) & isfinite(SWE2);
Ix2=isfinite(SWE) & isfinite(SWE3);
dSWE1=SWE2(Ix)-SWE(Ix)
dSWE2=SWE3(Ix2)-SWE(Ix2)
dH1=H2(Ix)-H(Ix)
dH2=H3(Ix2)-H(Ix2)
G1b=ones(size(dSWE1));
G2b=2*ones(size(dSWE2));
dSWEall=[dSWE1;dSWE2];
dHall=[dH1;dH2];
Gball=[G1b;G2b];

L2={'S1_pits-S2_pits','S1_pits-S2_FedSampler'};
subplot(2,4,4)
h=boxplot(dHall,Gball,'notch','on','Labels',L2); grid on
set(h,'linewidth',2)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
ylabel('depth [cm]')
subplot(2,4,8)
h=boxplot(dSWEall,Gball,'notch','on','Labels',L2); grid on
set(h,'linewidth',2)
set(gca,'LineWidth',2,'FontSize',14,'FontWeight','bold')
ylabel('SWE [cm]')
%%

