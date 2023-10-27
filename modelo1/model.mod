set distritos;
set parkings;


param llamadas{distritos};
param Y{distritos, parkings};

var X{i in parkings,j in distritos: (i!=1) or (j!=3)} integer >= 0;

minimize funcion_tiempo: sum{i in parkings, j in distritos} (X[i, j] * Y[i, j]);

s.t. atender_todas_las_llamadas{i in distritos}:
	sum{j in parkings} X[i, j] = llamadas[i];

s.t. maximo_de_10000{j in parkings}:
	sum{i in distritos} X[i, j] <= 10000;

s.t. repartir_esfuerzo{j in parkings, k in parkings}:
    sum{i in distritos} X[i, j] <= 1.5 * sum{i in distritos} X[i, k];

end;
