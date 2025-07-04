%Template RT1 Versuch Matlab 2
%Level 2 M-File S-Function zur Simulation 

% Anmerkung: Dieses Dokument muss nicht ausgeführt werden, nur gespeichert 

function msfunction_template(block)

  setup(block);
 
% Endfunction

% Initialisierung
function setup(block)

  % Anzahl der Ein- und Ausgänge des gesamten S-Function-Blocks
  block.NumInputPorts   = 1;                     % TODO: Zahl der Eingänge auf 1 setzen
  block.NumOutputPorts  = 1;                     % TODO: Zahl der Ausgänge auf 1 setzen
  
  % Anzahl der Zustände
  block.NumContStates   = 2;                     % TODO: Anzahl der Zustände setzen
  
  % Anzahl der Parameter
  block.NumDialogPrms   = 1;                     % TODO: Anzahl der Parameter setzen
                                                % Achtung: Vektor der Anfangsbedingung wird als Parameter übergeben
  
  % Dimension der Eingangsports
  block.InputPort(1).Dimensions = 1;             % TODO: Dimension des Eingangsports setzen (entspricht Dimension der Stellgröße)
  block.InputPort(1).SamplingMode = 'Sample';

  
  % Dimension der Ausgangsports
  block.OutputPort(1).Dimensions = 1;            % TODO: Dimension des Ausgangsports setzen (entspricht Dimension des Zustandsvektors
  block.OutputPort(1).SamplingMode = 'Sample';
  
  % Einstellen der Abtastzeit: [0 0] entspricht einer variablen Abtastzeit
  % für zeitkontinuierliche Systeme
  block.SampleTimes = [0 0];
  
  % Registrieren der einzelnen Methoden
  block.RegBlockMethod('InitializeConditions',  @InitConditions);
  block.RegBlockMethod('Outputs',               @Outputs);
  block.RegBlockMethod('Derivatives',           @Derivatives);
  block.RegBlockMethod('Terminate',             @Terminate);
  
% Endfunction

function InitConditions(block)

  % Eingabe der Anfangsbedingungen
  x0 = block.DialogPrm(1).Data;                 % Anmerkung: hier wird der erste Parameter aus dem Dialogfeld als Anfangsbedingung gesetzt   
  block.ContStates.Data = x0;   
  
% Endfunction

function Outputs(block)
  % Zuweisung der Zustände, Eingänge und Parameter auf die in Maple
  % definierten Namen
  
  x = block.ContStates.Data;
  block.OutputPort(1).Data = x(1);   
  
% Endfunction 

function Derivatives(block)

 %    p     = block.DialogPrm(2).Data;          % Anmerkung: da in den Vorbereitungsaufgaben keine weiteren Parameter benötigt werden,
                                                % kann diese Zeile hier auskommentiert werden  
     u     = block.InputPort(1).Data;       
     x1  = block.ContStates.Data(1);
     x2 = block.ContStates.Data(2);


     % Rechte Seite      
     f = [-x1^3 + x2;
          x1 * x2 - 1 + u         
         ];                                     % TODO: rechte Seite des Modells angeben
     
     block.Derivatives.Data = f;
  
% Endfunction

function Terminate(block)