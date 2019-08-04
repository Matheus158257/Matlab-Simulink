%%
%%%%%%%%% Questão 1 %%%%%%%%%
    %sim('Q1',4/60)
    
    vD1 = simlog.D1.v.series; 
    vD4 = simlog.D4.v.series;
    iD1 = simlog.D1.i.series; 
    iD4 = simlog.D4.i.series;
    

 
    title('Tensão no diodo 1')
    plot(vD1)
    legend('Vd1');
    xlabel('wt[radians*s]')
    ylabel('Vd[V]')


    title('Tensão no diodo 4')
    plot(vD4)
    legend('Vd4');
    xlabel('wt[radians*s]')
    ylabel('Vd[V]')
%%
    figure(2)
        subplot(2,1,1)
        plot(iD1)
        title('Corrente nos diodos')
        legend('Id1');
        xlabel('wt[radians*s]')
        ylabel('Id[A]')

        subplot(2,1,2)
        plot(vD4)
        legend('Id4');
        xlabel('wt[radians*s]')
        ylabel('Id[A]')

%%