function [I_sort,ind]=GA(sigma,n)

I=zeros(n+1,2^n);
I(1,1) = 2/sigma^2; %初始信道容量

for i=1:n
    for p=1:2^(i-1)
        if 0<I(i,p)&&I(i,p)<10
            y=1-(1-f(I(i,p)))^2;
            if  y>=0.0385&&y<=1.022
            I(i+1,2*p-1)=bifindf(y);
            end
            if y<0.0385
            I(i+1,2*p-1)=bifindf1(y);
            
            end
        end
        if I(i,p)>=10
            y=1-(1-f1(I(i,p)))^2;
            if  y>=0.0385&&y<=1.022
            I(i+1,2*p-1)=bifindf(y);
            end
            if y<0.0385
            I(i+1,2*p-1)=bifindf1(y);
            end
        end
        
        %             I(i+1,2*p-1) = I(i,p)^2;
        I(i+1,2*p) = 2*I(i,p);
    end
end

Pe=0.5*erfc(0.5*sqrt(I(n+1,:)));
[I_sort,ind]=sort(Pe,'descend');

