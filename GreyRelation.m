function [ relationCoefficient ] = GreyRelation( referSeries , testSeries)
%[ relationCoefficient ] = GreyRelation( referSeries , testSeries)
    x = testSeries;
    x0 = referSeries;
    [m, n] = size(x);
    sx0 = size(x0);
    if m ~= sx0(1) || n ~= sx0(2) 
        error('Series sizes unmatch!');
    end
    for i = 1:n
        avg(i)=0; 
    end

    for i=1:m 
        for j=1:n
           avg(j)=avg(j)+x(i,j);
        end
    end

    for i=1:n
        avg(i)=avg(i)/m;
    end
    for j=1:m
        for i=1:n
            x(j,i)=x(j,i)/avg(i);
        end
    end

    for i = 1:n
        x0(i)=x0(i)/avg(i);
    end
    for j = 1 : m
        for i = 1 : n
            delta(j,i)=abs(x(j,i)-x0(i));
        end
    end
    max = delta(1,1);
    for j = 1:m
        for i = 1:n
            if delta(j,i) > max
                max = delta(j,i);
            end
        end
    end

    min = 0;

    for j = 1 : m
        xgd(j)=0;
        for i = 1 : n
            glxs(j,i) = 0.5 * max / (0.5*max+delta(j,i));%计算关联系数及相关度
            xgd(j)=xgd(j)+glxs(j,i);
        end
        xgd(j)=xgd(j)/n;
    end
    relationCoefficient = xgd;
end


