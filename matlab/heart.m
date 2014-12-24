
function heart()
    fps = 10;
    n = 36
    
    figure;
    hold on;
    axis([-1 1 -1 1]);
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    set(gca,'xcolor',[1,1,1],'ycolor',[1,1,1]);
    %axis off;
    for i = -n : -1
        t1 = i;
        t2 = i + n;
        draw(t1, t2, n);
        frame(i + n + 1) = getframe;
        pause(1/fps);
    end
    
    for i = 0 : (2*n-1) 
        t1 = i;
        t2 = 2 * i + n;
        draw(t1, t2, n);
        frame(i + n + 1) = getframe;
        pause(1/fps);
    end

    for i = 2*n : 3*n
        t1 = i;
        t2 = i - n;
        draw(t1, t2, n);
        frame(i + n + 1) = getframe;
        pause(1/fps);
    end
    
    filename = 'heart.gif';
    nframe = length(frame);
    for i = 1: nframe
        [image, map] = frame2im(frame(i));
        [img, cmap] = rgb2ind(image,128);
        if i==1
            imwrite(img, cmap, filename,'gif');
        else
            imwrite(img, cmap, filename, 'writeMode','append', 'delaytime', 1 / fps)
        end
    end
end

function draw(t1, t2, n)
    L = 1;
    x1 = L * cos(t1 / 2 / n * pi);
    y1 = L * sin(t1 / 2 / n * pi);
    x2 = L * cos(t2 / 2 / n * pi);
    y2 = L * sin(t2 / 2 / n * pi);
    plot([x1, x2],[y1, y2], 'r');
end


