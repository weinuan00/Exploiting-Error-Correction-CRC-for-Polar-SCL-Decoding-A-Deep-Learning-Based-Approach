function x0=bifindf(ytest)
a=0;
b=10;
y1=f(a)-ytest;
y2=f(b)-ytest;
x0=(a+b)/2;
while (b-a)>10^(-8)
    if y1*y2<0
        x0=(a+b)/2;
        if (f(x0)-ytest)*y1<0
            b=x0;
        end
        if  (f(x0)-ytest)*y2<0
            a=x0;
        end
        if (f(x0)-ytest)==0          
            break;
        end
    y1=f(a)-ytest;
    y2=f(b)-ytest;
    else
        break;
    end
    
end

        