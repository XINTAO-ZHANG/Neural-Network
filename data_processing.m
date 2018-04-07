% uppercase letter: annotation
% lowercase letter: combined dataset
N = 1;
R = 2;
V = 3; A = 4; L = 5; F = 6; E = 7; j = 8;

% N 
N_100 = read_beats('100m.mat','clean_100.txt',N,262);
N_101 = read_beats('101m.mat','clean_101.txt',N,262);
N_106 = read_beats('106m.mat','clean_106.txt',N,262);
N_200 = read_beats('200m.mat','clean_200.txt',N,262);
N_203 = read_beats('203m.mat','clean_203.txt',N,262);
N_208 = read_beats('208m.mat','clean_208.txt',N,262);
N_209 = read_beats('209m.mat','clean_209.txt',N,262);
N_212 = read_beats('212m.mat','clean_212.txt',N,262);
N_213 = read_beats('213m.mat','clean_213.txt',N,262);
N_215 = read_beats('215m.mat','clean_215.txt',N,262);
N_222 = read_beats('222m.mat','clean_222.txt',N,262);
N_223 = read_beats('223m.mat','clean_223.txt',N,262);
N_231 = read_beats('231m.mat','clean_231.txt',N,262);
n = [N_100 N_101 N_106 N_200 N_203 N_208 N_209 N_212 N_213 N_215 N_222 N_223 N_231];
n(end+1,:) = N;

% R
R_207 = read_beats('207m.mat','clean_207.txt',R,262);
R_212 = read_beats('212m.mat','clean_212.txt',R,262);
R_231 = read_beats('231m.mat','clean_231.txt',R,262);
R_232 = read_beats('232m.mat','clean_232.txt',R,262);
r = [R_207 R_212 R_231 R_232];
r(end+1,:) = R;


% V
V_106 = read_beats('106m.mat','clean_106.txt',V,262);
V_109 = read_beats('109m.mat','clean_109.txt',V,262);
V_200 = read_beats('200m.mat','clean_200.txt',V,262);
V_203 = read_beats('203m.mat','clean_203.txt',V,262);
V_208 = read_beats('208m.mat','clean_208.txt',V,262);
V_213 = read_beats('213m.mat','clean_213.txt',V,262);
V_214 = read_beats('214m.mat','clean_214.txt',V,262);
V_215 = read_beats('215m.mat','clean_215.txt',V,262);
V_223 = read_beats('223m.mat','clean_223.txt',V,262);
v = [V_106 V_109 V_200 V_203 V_208 V_213 V_214 V_215 V_223];
v(end+1,:) = V;


% A
A_207 = read_beats('207m.mat','clean_207.txt',A,262);
A_209 = read_beats('209m.mat','clean_209.txt',A,262);
A_222 = read_beats('222m.mat','clean_222.txt',A,262);
A_223 = read_beats('223m.mat','clean_223.txt',A,262);
A_232 = read_beats('232m.mat','clean_232.txt',A,262);
a = [A_207 A_209 A_222 A_223 A_232];
a(end+1,:) = A;


% L
L_109 = read_beats('109m.mat','clean_109.txt',L,262);
L_111 = read_beats('111m.mat','clean_111.txt',L,262);
L_207 = read_beats('207m.mat','clean_207.txt',L,262);
L_214 = read_beats('214m.mat','clean_214.txt',L,262);
l = [L_109 L_111 L_207 L_214];
l(end+1,:) = L;

% F
F_208 = read_beats('208m.mat','clean_208.txt',F,262);
F_213 = read_beats('213m.mat','clean_213.txt',F,262);
f = [F_208 F_213];
f(end+1,:) = F;



% % E
E_207 = read_beats('207m.mat','clean_207.txt',E,262);
e = E_207;
e(end+1,:) = E;

heartbeats = [n r v a l f e];
heartbeats = heartbeats';
csvwrite('heartbeats.csv',heartbeats);


