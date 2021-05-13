% Función de Transferencia [z]
N = [0.003485, 0.007524, 0.001394]; % Matriz del Numerador de la función
D = [1, -1.26, 0.09419, 0.1748];    % Matriz del Denominador de la función
ts = 0.0593;                        % Tiempo de muestreo
t = 0:0.0593:5;                     % Vector de tiempo para la simulación
Tf = tf(N,D,ts);                    % Definición de la función de transferencia
Gs = d2c(Tf);                       % Conversión del modelo a tiempo continuo

% Variables ZN
Ku = 259.933;                       % Valor de la ganancia última
Pu = (2*pi)/(32.1483);              % Valor del periodo último
    
% Reglas de Ziegler Nichols
Kp = 0.6*(Ku);                      
Ki = Pu/2;
Kd = Pu/8;
% Controlador    
C = pid(Kp,Ki,Kd);                  % Función del controlador PID en tiempo continuo
M = series(C,Gs);                   % Multiplicación de bloques en serie
G = (feedback(M,1));                % Retroalimentación unitaria con salida del sistema

step(G,t)                           % Gráfica de la respuesta del sistema a una señal escalón unitario
    
