function [ forecastSeries , errorRange ] = GreyForecast( originSeries , foreLen , doPlot )
%GreyForecast,GM(1,1)
%[ forecastSeries , errorRange ] = GreyForecast( originSeries , foreLen , doPlot )
    if nargin < 2 || nargin > 3
        error('Unmatched arguments.')
    end
    if nargin ~= 3
        doPlot = false;
    end
    y = originSeries;
    n=length(y);
    yy=ones(n,1);
    yy(1)=y(1);
    for i=2:n
        yy(i)=yy(i-1)+y(i);
    end
    B=ones(n-1,2);
    for i=1:(n-1)
        B(i,1)=-(yy(i)+yy(i+1))/2;
        B(i,2)=1;
    end
    BT=B';
    for j=1:n-1
        YN(j)=y(j+1);
    end
    YN=YN';
    A = (BT*B) \ (BT*YN);
    a=A(1);
    u=A(2);
    t=u/a;
    i=1:foreLen+n;
    yys(i+1)=(y(1)-t).*exp(-a.*i)+t;
    yys(1)=y(1);
    for j=n+foreLen:-1:2
        ys(j)=yys(j)-yys(j-1);
    end
    x=1:n;
    xs=2:n+foreLen;
    yn=ys(2:n+foreLen);
    det=0;
    for i=2:n
        det=det+abs(yn(i)-y(i));
    end
    det=det/(n-1);
    errorRange = det / 100;
    forecastSeries = ys(n+1:n+foreLen);
    if doPlot ~= false
        plot(x,y,'^r',xs,yn,'*-b');
    end
end

