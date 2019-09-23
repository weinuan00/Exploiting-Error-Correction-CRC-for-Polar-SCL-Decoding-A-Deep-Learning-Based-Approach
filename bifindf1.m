function x0=bifindf1(ytest)
a=10;
b=10^32;
y1=f1(a)-ytest;
y2=f1(b)-ytest;
x0=(a+b)/2;
while (b-a)>10^(-8)
    
    if y1*y2<0
        x0=(a+b)/2;
        if (f1(x0)-ytest)*y1<0
            b=x0;
        end
        if  (f1(x0)-ytest)*y2<0
            a=x0;
        end
        if (f1(x0)-ytest)==0          
            break;
        end
    y1=f1(a)-ytest;
    y2=f1(b)-ytest;
    else
        break;
    end
    
end

        