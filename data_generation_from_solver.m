define_constants
mpc=loadcase('case5');
[Busrows,BusColumns] = size(mpc.bus);
Nbus = Busrows;
NbOfSimulations = 10;
Pd=zeros(NbOfSimulations,Nbus);
Va=zeros(NbOfSimulations,Nbus);
[genrows,gencolumn] = size(mpc.gen);
Pg=zeros(NbOfSimulations,genrows);
Success = zeros(NbOfSimulations,1);
Percentage = 0.1;

PdBuses =  mpc.bus(:,1);
PgBuses = mpc.gen(:,1);
for j=1 : Nbus
    PloadDefault= mpc.bus(j,PD);
    Pmin = (1- Percentage)*PloadDefault ;
    Pmax = (1+ Percentage)*PloadDefault;
    r = (Pmax-Pmin).*rand(NbOfSimulations,1) + Pmin;
    Pd(:,j)= r;
end

for i = 1:NbOfSimulations
    mpc.bus(:,PD) = Pd(i,:) ;
    results= rundcopf(mpc);
    Pg(i,:)= results.gen(:,PG);
    Va(i,:)= results.bus(:,VA);
    Success(i,:) = results.success;
end
disp('Matrix of Pd values')
disp(Pd)
disp('Matrix of Pg values')
disp(Pg)
disp('Matrix of Va values')
disp(Va)
disp('Simulation Success Matrix')
disp(Success)

PdBuses = transpose(PdBuses);
PgBuses = transpose(PgBuses);
NewPd = [PdBuses; Pd];
NewVa = [PdBuses;Va];
NewPg = [PgBuses; Pg];
disp(NewPd)
disp(NewPg)
disp(NewVa)

writematrix(NewPd,'Pd.csv') 
writematrix(NewPg,'Pg.csv')
writematrix(NewVa,'Va.csv')
writematrix(Success,'Success.csv')