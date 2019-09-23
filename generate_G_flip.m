function G = generate_G_flip(m)
N = 2^m;
F1=[1 0;1 1];
F=F1;
for p=1:m-1
    F=kron(F,F1);
end


a0=[];
for j=1:N
a0=[a0,bin2dec(fliplr(dec2bin(j-1,m)))+1];
end
for i=1:N
    G(:,i)=F(:,a0(i));
end