  %%%%%%%%%%%%%%%%%% Projeto Robótica %%%%%%%%%%%%%%%%%% 
  %% Vetores das variáveis e suas derivadas em função do tempo.
  
 syms t  
  
 aCst = 8;
 VCst = 0.4;
  
 tra = [1,2,1,2,1,2,1,2,1,2,1,1,2,1,2,1,2,1,2];
 alpha = [aCst,aCst,-aCst,aCst,aCst,aCst,-aCst,aCst,aCst,aCst,-aCst,aCst,aCst,-aCst,aCst,aCst,aCst,-aCst,-aCst];
 x0 = [0,4,4,0,0,4,4,0,0,4,4,0,3.75,3.75,0.75,0.75,3.75,3.75,0];
 xf = [4,4,0,0,4,4,0,0,4,4,0,3.75,3.75,0.75,0.75,3.75,3.75,0,0];
 y0 = [0,0,0.2,0.2,0.4,0.4,0.6,0.6,0.8,0.8,1,1,1,1.1667,1.1667,1.3333,1.3333,1.5,1.5];
 yf = [0,0.2,0.2,0.4,0.4,0.6,0.6,0.8,0.8,1,1,1,1.1667,1.1667,1.3333,1.3333,1.5,1.5,0];
 tf = [10.05,0.55,10.05,0.55,10.05,0.55,10.05,0.55,10.05,0.55,10.05,8.175,0.4668,6.3,0.4668,6.3,0.4668,8.175,3.8];
 V = [VCst,VCst,-VCst,VCst,VCst,VCst,-VCst,VCst,VCst,VCst,-VCst,VCst,VCst,-VCst,VCst,VCst,VCst,-VCst,-VCst];
 tb = 0.05;
 z = 0.5;

for j = 1:1:length(tra)
    if tra(j) == 1
        k0 = x0(j);
        kf = xf(j);
    else
        k0 = y0(j);
        kf = yf(j);
    end
    
    done1 = 0;
    done2 = 0;
    
    for m = 0:0.01:tf(j)
        
        if (j == 1) && (m == 0)
            k1(t) = k0 + (alpha(j)/2)*(t^2);
            
            d1 = z;
            d2 = k1(t);
            d3 = -y0(j);
            th4 = 0;
            
        elseif m == 0 
            k1(t) = k0 + (alpha(j)/2)*(t^2);
            
            if tra(j) == 1
                d1 = [d1 z];
                d2 = [d2 k1(t)];
                d3 = [d3 -y0(j)];
                th4 = [th4 0];
            else
                d1 = [d1 z];
                d2 = [d2 x0(j)];
                d3 = [d3 -k1(t)];
                th4 = [th4 0];
            end
            
        elseif m > tb && done1 ~= 1
            k2(t)= (kf+k0-V(j)*tf(j))/2 +V(j)*t;
            done1 = 1;
            
            if tra(j) == 1
                d1 = [d1 z];
                d2 = [d2 k2(t)];
                d3 = [d3 -y0(j)];
                th4 = [th4 0];
            else
                d1 = [d1 z];
                d2 = [d2 x0(j)];
                d3 = [d3 -k2(t)];
                th4 = [th4 0];
            end
      
        elseif m > (tf(j) - tb) && done2 ~= 1
            k3(t)= kf-(alpha(j)/2)*(tf(j)^2)+alpha(j)*tf(j)*t-(alpha(j)/2)*(t^2);
            done2 = 1;

            if tra(j) == 1
                d1 = [d1 z];
                d2 = [d2 k3(t)];
                d3 = [d3 -y0(j)];
                th4 = [th4 0];
            else
                d1 = [d1 z];
                d2 = [d2 x0(j)];
                d3 = [d3 -k3(t)];
                th4 = [th4 0];
            end
        
        else
            s = length(d1);
            d1 = [d1 d1(s)];
            d2 = [d2 d2(s)];
            d3 = [d3 d3(s)];
            th4 = [th4 0];
        end
    end
end 

d1_dot = diff(d1,t);
d2_dot = diff(d2,t);
d3_dot = diff(d3,t);
th4_dot = diff(th4,t);
            
d1_dot2 = diff(d1_dot,t);
d2_dot2 = diff(d2_dot,t);
d3_dot2 = diff(d3_dot,t);
th4_dot2 = diff(th4_dot,t);

%% Valores das variáveis no tempo
temp=1;
tempTot=0;
tempV = zeros(1,length(d1));
d1V = zeros(1,length(d1));
d2V = zeros(1,length(d2));
d3V = zeros(1,length(d3));
th4V = zeros(1,length(th4));

for j = 1:1:length(tra)
    for m = 0:0.01:tf(j)
        tempV(temp) = m+tempTot;
        
        d1V(temp) = subs(d1(temp),t,m);
        d2V(temp) = subs(d2(temp),t,m);
        d3V(temp) = subs(d3(temp),t,m)+1.5;
        th4V(temp) = subs(th4(temp),t,m);
        
        temp = temp+1;
    end
    tempTot = tempTot + tf(j);
end 

subplot(4,1,1);
plot(tempV,d1V)
title('d1')

subplot(4,1,2);
plot(tempV,d2V)
title('d2')

subplot(4,1,3);
plot(tempV,d3V)
title('d3')

subplot(4,1,4);
plot(tempV,th4V)
title('theta4')

%% Valores das velocidades das variáveis no tempo
temp=1;
tempTot=0;
tempV = zeros(1,length(d1_dot));
d1_dotV = zeros(1,length(d1_dot));
d2_dotV = zeros(1,length(d2_dot));
d3_dotV = zeros(1,length(d3_dot));
th4_dotV = zeros(1,length(th4_dot));

for j = 1:1:length(tra)
    for m = 0:0.01:tf(j)
        tempV(temp) = m+tempTot;
        
        d1_dotV(temp) = subs(d1_dot(temp),t,m);
        d2_dotV(temp) = subs(d2_dot(temp),t,m);
        d3_dotV(temp) = subs(d3_dot(temp),t,m);
        th4_dotV(temp) = subs(th4_dot(temp),t,m);
        
        temp = temp+1;
    end
    tempTot = tempTot + tf(j);
end 

subplot(4,1,1);
plot(tempV,d1_dotV)
title('vel d1')

subplot(4,1,2);
plot(tempV,d2_dotV)
title('vel d2')

subplot(4,1,3);
plot(tempV,d3_dotV)
title('vel d3')

subplot(4,1,4);
plot(tempV,th4_dotV)
title('vel theta4')


%% Valores das acelerações das variáveis no tempo
temp=1;
tempTot=0;
tempV = zeros(1,length(d1_dot2));
d1_dot2V = zeros(1,length(d1_dot2));
d2_dot2V = zeros(1,length(d2_dot2));
d3_dot2V = zeros(1,length(d3_dot2));
th4_dot2V = zeros(1,length(th4_dot2));

for j = 1:1:length(tra)
    for m = 0:0.01:tf(j)
        tempV(temp) = m+tempTot;
        
        d1_dot2V(temp) = subs(d1_dot2(temp),t,m);
        d2_dot2V(temp) = subs(d2_dot2(temp),t,m);
        d3_dot2V(temp) = subs(d3_dot2(temp),t,m);
        th4_dot2V(temp) = subs(th4_dot2(temp),t,m);
        
        temp = temp+1;
    end
    tempTot = tempTot + tf(j);
end 

subplot(4,1,1);
plot(tempV,d1_dot2V)
title('acc d1')

subplot(4,1,2);
plot(tempV,d2_dot2V)
title('acc d2')

subplot(4,1,3);
plot(tempV,d3_dot2V)
title('acc d3')

subplot(4,1,4);
plot(tempV,th4_dot2V)
title('acc theta4')
