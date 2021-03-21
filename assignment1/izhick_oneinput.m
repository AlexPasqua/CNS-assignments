
function [] = izhick_oneinput(a,b,c,d,title_graph,volt,tau,final,step,type)
 tspan = 0:tau:final;

uu=[];  ww=[];
start_input_plot=-90;  
if(type=="depolarizing")
u=-70; T1 = 10;
else
u=-70;  
end
    w=b*u;
for t=tspan
    if(type=="depolarizing")
        if abs(t-T1)<1 
        current=20;
        else
        current=0;
        end
    else
        if(t<step || t>=(step+step))
          current=0;
        else 
           current=volt;
        end
    end
u= u + tau*(0.04*u^2+5*u+140-w+current);
w = w + tau*a*(b*u-w);
if u > 30
        uu(end+1)=30;
        u = c;
        w = w + d;
   
else
    uu(end+1)=u;
end
    ww(end+1)=w;
end
f=figure('visible','on');
subplot(2,1,1);
if(type=="depolarizing")
     plot(tspan,uu,[0 T1-1 T1-1 T1+1 T1+1 max(tspan)],-90+[0 0 10 10 0 0]);
else
plot(tspan,uu,[0 step step step+step step+step final],-90+[0 0 10 10 0 0]);
  
   end
axis([0 max(tspan) start_input_plot 30])
xlabel('t')
ylabel('u')
title(title_graph);
subplot(2,1,2);
plot(uu,ww);
xlabel('membran potential')
ylabel('recovery variable')
plot_spikes(f,title_graph);

end
