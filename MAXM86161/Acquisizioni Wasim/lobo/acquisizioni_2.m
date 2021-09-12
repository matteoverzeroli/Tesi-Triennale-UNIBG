%%
%@author Wasim Essbai
%%
close all
figure

subplot(3,1,1)
plot(lobosxmaxmavg1100Hz.Channel1, 'g')
subplot(3,1,2)
plot(lobosxmaxmavg1100Hz.Channel2, 'm')
subplot(3,1,3)
plot(lobosxmaxmavg1100Hz.Channel3, 'r')

pos_iniziale = 900;

flag = lobosxmaxmavg1100Hz.timestamp >= lobosxmaxmavg1100Hz.timestamp(pos_iniziale) & lobosxmaxmavg1100Hz.timestamp < lobosxmaxmavg1100Hz.timestamp(pos_iniziale)+10000

milli_zero = lobosxmaxmavg1100Hz.timestamp(pos_iniziale)

time = lobosxmaxmavg1100Hz.timestamp-milli_zero
time = time ./1000

f = figure
plot(time(flag),lobosxmaxmavg1100Hz.Channel1(flag), 'g')
xlabel('Tempo [s]');
ylabel('Valore ADC');
legend('LED GREEN','Location','Northeast');
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'green.pdf','Resolution',600)

f = figure
plot(time(flag),lobosxmaxmavg1100Hz.Channel2(flag), 'm')
xlabel('Tempo [s]');
ylabel('Valore ADC');
legend('LED IR','Location','Northeast');
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'ired.pdf','Resolution',600)

f = figure
plot(time(flag),lobosxmaxmavg1100Hz.Channel3(flag), 'r')
xlabel('Tempo [s]');
ylabel('Valore ADC');
legend('LED RED','Location','Northeast');
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'red.pdf','Resolution',600)

%%Campioni filtrati

%GREEN
f = figure
samplepersecond = 10;

flag = lobosxmaxmavg1100Hz.timestamp >= lobosxmaxmavg1100Hz.timestamp(pos_iniziale) & lobosxmaxmavg1100Hz.timestamp < lobosxmaxmavg1100Hz.timestamp(pos_iniziale)+10000

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == 1
        i
        break
    end
end
flag((i+1):(i+samplepersecond))= 1
test = flag

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == -1
        i
        break
    end
end
test(i+1:i+samplepersecond) = 0

milli_zero = lobosxmaxmavg1100Hz.timestamp(pos_iniziale)
time = lobosxmaxmavg1100Hz.timestamp-milli_zero
time = time ./1000

milli_zero_avg = lobosxmaxmavg1100Hz.timestamp(pos_iniziale+samplepersecond)
time_avg = lobosxmaxmavg1100Hz.timestamp-milli_zero_avg
time_avg = time_avg ./1000

coeff = ones(1, samplepersecond)/samplepersecond;
smoothed = filter(coeff, 1, lobosxmaxmavg1100Hz.Channel1(flag));
plot(time_avg(test), smoothed(samplepersecond+1:end),'g')
legend('LED GREEN','Location','Northwest')
xlabel('Tempo [s]');
ylabel('Valore ADC');
xlim([0 10])
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'lobo_green_moving_avg.pdf','Resolution',600)
%IR
f = figure
samplepersecond = 35;

flag = lobosxmaxmavg1100Hz.timestamp >= lobosxmaxmavg1100Hz.timestamp(pos_iniziale) & lobosxmaxmavg1100Hz.timestamp < lobosxmaxmavg1100Hz.timestamp(pos_iniziale)+10000

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == 1
        i
        break
    end
end
flag((i+1):(i+samplepersecond))= 1
test = flag

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == -1
        i
        break
    end
end
test(i+1:i+samplepersecond) = 0

milli_zero = lobosxmaxmavg1100Hz.timestamp(pos_iniziale)
time = lobosxmaxmavg1100Hz.timestamp-milli_zero
time = time ./1000

milli_zero_avg = lobosxmaxmavg1100Hz.timestamp(pos_iniziale+samplepersecond)
time_avg = lobosxmaxmavg1100Hz.timestamp-milli_zero_avg
time_avg = time_avg ./1000

coeff = ones(1, samplepersecond)/samplepersecond;
smoothed = filter(coeff, 1, lobosxmaxmavg1100Hz.Channel2(flag));
plot(time_avg(test), smoothed(samplepersecond+1:end),'m')
legend('LED IR','Location','Northwest')
xlabel('Tempo [s]');
ylabel('Valore ADC');
xlim([0 10])
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'lobo_ir_moving_avg.pdf','Resolution',600)

%RED
f = figure
samplepersecond = 30;

flag = lobosxmaxmavg1100Hz.timestamp >= lobosxmaxmavg1100Hz.timestamp(pos_iniziale) & lobosxmaxmavg1100Hz.timestamp < lobosxmaxmavg1100Hz.timestamp(pos_iniziale)+10000

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == 1
        i
        break
    end
end
flag((i+1):(i+samplepersecond))= 1
test = flag

for i=1:length(flag)
    if int8(flag(i))-int8(flag(i+1)) == -1
        i
        break
    end
end
test(i+1:i+samplepersecond) = 0

milli_zero = lobosxmaxmavg1100Hz.timestamp(pos_iniziale)
time = lobosxmaxmavg1100Hz.timestamp-milli_zero
time = time ./1000

milli_zero_avg = lobosxmaxmavg1100Hz.timestamp(pos_iniziale+samplepersecond)
time_avg = lobosxmaxmavg1100Hz.timestamp-milli_zero_avg
time_avg = time_avg ./1000

coeff = ones(1, samplepersecond)/samplepersecond;
smoothed = filter(coeff, 1, lobosxmaxmavg1100Hz.Channel3(flag));
plot(time_avg(test), smoothed(samplepersecond+1:end),'r')
legend('LED RED','Location','Northwest')
xlabel('Tempo [s]');
ylabel('Valore ADC');
xlim([0 10])
f.Position(3:4) = [1511, 189]
set(f,'PaperSize',[1511 189])
exportgraphics(f,'lobo_red_moving_avg.pdf','Resolution',600)