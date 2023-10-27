set distritos;
set parkings;


param llamadas{distritos};
param Y{distritos, parkings};

var considerar{distritos, parkings}, binary;

var X{i in distritos,j in parkings: ((i!=3) or (j!=1)) and ((i!=4) or(j!=3)) and ((i!=6) or (j!=1))} integer >= 0;


minimize funcion_tiempo: sum{i in distritos, j in parkings} (X[i, j] * Y[i, j]);

s.t. atender_todas_las_llamadas{i in distritos}:
	sum{j in parkings} X[i, j] = llamadas[i];

s.t. maximo_de_10000{j in parkings}:
	sum{i in distritos} X[i, j] <= 10000;

s.t. repartir_esfuerzo{j in parkings, k in parkings}:
    sum{i in distritos} X[i, j] <= 1.5 * sum{i in distritos} X[i, k];

s.t. repartir_porencimade_7500{i in distritos, j in parkings}:
	if(llamadas[i] >=7500) then X[i,j]+1 <= llamadas[i];

s.t. minimo_10a{i in distritos, j in parkings}:
	10000000*considerar[i,j] >= X[i,j];

s.t. minimo_10b{i in distritos, j in parkings}:
	considerar[i,j]*llamadas[i]/10<=X[i,j];

end;
