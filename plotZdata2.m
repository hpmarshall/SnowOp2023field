function h=plotZdata(ax,r,clim,imAlpha)
% plot image of data in r.Z, making NaN values transparent and using clim
% for colorscale
% INPUT: ax = axis handle
%        r.x = xdata
%        r.y = ydata
%        r.Z = Zdata
%       clim = colorbar limits
%       Tmask = transparancy mask
% OUTPUT: h = handle to image

if nargin<4
    imAlpha=ones(size(r.Z));
    Ix=isnan(r.Z);
    imAlpha(Ix)=0;
end
if nargin<2
    clim=[min(r.Z(:)) max(r.Z(:))];
end
h=imagesc(ax,r.x,r.y,r.Z);
set(h,'AlphaData',imAlpha)
set(gca,'Clim',clim);
set(gca,'Ydir','normal','LineWidth',2,'FontSize',14,'FontWeight','bold')
colorbar
axis equal; axis tight; grid on