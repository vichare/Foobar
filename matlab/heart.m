
function heart()
    fps = 5;
    
    figure;
    hold on;
    axis([-1 1 -1 1]);
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    for i = -9 : -1
        t1 = i;
        t2 = i + 9;
        draw(t1, t2);
        frame(i + 10) = getframe;
        pause(1/fps);
    end
    
    for i = 0 : 17
        t1 = i;
        t2 = 2 * i + 9;
        draw(t1, t2);
        frame(i + 10) = getframe;
        pause(1/fps);
    end

    for i = 18 : 27
        t1 = i;
        t2 = i - 9;
        draw(t1, t2);
        frame(i + 10) = getframe;
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

function draw(t1, t2)
    L = 1;
    x1 = L * cos(t1 / 18 * pi);
    y1 = L * sin(t1 / 18 * pi);
    x2 = L * cos(t2 / 18 * pi);
    y2 = L * sin(t2 / 18 * pi);
    plot([x1, x2],[y1, y2], 'r');
end


