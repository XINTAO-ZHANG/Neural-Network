% -----------------USE FUNCTION TO READ IN DATA-------------

N = 1;
R = 2;
V = 3; 
A = 4;
L = 5;
F = 6; 
E = 7; 
j = 8;

% extract training and testing heartbeats
training_size = 180;
test_size = 100;
% N_231 = read_beats('231m.mat','clean_231.txt',N,1,1+training_size-1);
% R_231 = read_beats('231m.mat','clean_231.txt',R,1,1+training_size-1);
% N_215 = read_beats('215m.mat','clean_215.txt',N,100,100+training_size-1);
% V_215 = read_beats('215m.mat','clean_215.txt',V,50,50+training_size-1);
%L_109 = read_beats('109m.mat','clean_109.txt',L,3,3+training_size-1,262);
% V_109 = read_beats('109m.mat','clean_109.txt',V,1,1+training_size-1);
% V_207 = read_beats('207m.mat','clean_207.txt',V,20,20+training_size-1);
%V_200 = read_beats('200m.mat','clean_200.txt',V,1,1+training_size-1,262);
L_111 = read_beats('111m.mat','clean_111.txt',L,500,500+training_size-1,262);
V_203 = read_beats('203m.mat','clean_203.txt',V,200,200+training_size-1,262);


% R_231_test = read_beats('231m.mat','clean_231.txt',R,200,200+test_size-1);
% N_231_test = read_beats('231m.mat','clean_231.txt',N,200,200+test_size-1);
% N_100_test = read_beats('100m.mat','clean_100.txt',N,100,100+test_size-1);
% R_212_test = read_beats('212m.mat','clean_212.txt',N,100,100+test_size-1);
% N_215_test = read_beats('215m.mat','clean_215.txt',N,100,100+test_size-1);
% V_215_test = read_beats('215m.mat','clean_215.txt',V,3,3+test_size-1);
% L_109_test = read_beats('109m.mat','clean_109.txt',L,300,300+test_size-1);
% V_207_test = read_beats('207m.mat','clean_207.txt',V,51,51+test_size-1);
% L_207_test = read_beats('207m.mat','clean_207.txt',L,51,51+test_size-1);
% V_200_test = read_beats('200m.mat','clean_200.txt',V,100,100+test_size-1);
L_111_test = read_beats('111m.mat','clean_111.txt',L,1,1+test_size-1,262);
V_203_test = read_beats('203m.mat','clean_203.txt',V,1,1+test_size-1,262);
% V_109_test = read_beats('109m.mat','clean_109.txt',V,200,200+training_size-1);

patterns = [L_111 V_203];

%Randomize the order of the training set 
order1=randperm(training_size);
order2=randperm(training_size)+training_size;
order=[order1,order2];
for i=1:(2*training_size)
    patterns(:,order(i))=patterns(:,order(i))/norm(patterns(:,order(i)));
end
test_set = [L_111_test V_203_test];

% Learning
eta = 2;
% CHANGE INPUT_UNIT TO 359 WHEN USING DIFF SEQ
input_unit = 262;
hidden_unit = 100;
output_unit = 1;

epoch = 4000;
SSE = zeros(1,epoch);
w_fg = rand(hidden_unit,input_unit)-0.5;
w_gh = rand(output_unit,hidden_unit)-0.5;


% CHANGE THE TRAINING SET
% % USE DIFF SEQUENCE AS TRAINING SET
% patterns = [N_diff R_diff]; 

desired_output = zeros(1,training_size*2);
% first half of the training set is normal
desired_output(1:training_size) = 1;



for i = 1:epoch   
    for j = 1:(2*training_size)
        f = patterns(:,j);
        input_to_hidden = w_fg*f;
        g = activation_fn(input_to_hidden);   % hidden_activation
        input_to_output = w_gh*g;
        h = activation_fn(input_to_output);   % output_activation
        
%         compute the error
        output_error = desired_output(j)-h;
        
%         determine the weight changes
        dw_gh = eta * (diag(activation_diff_fn(w_gh*g))*output_error)*g';
        dw_fg = eta*diag(activation_diff_fn(w_fg*f)) * w_gh' * diag(output_error) * activation_diff_fn(w_gh*g) * f';
        
        w_fg = w_fg + dw_fg;
        w_gh = w_gh + dw_gh;
      
    end
    
%     compute the SSE over all input patterns for the current epoch
    g = activation_fn(w_fg*patterns);   % (50*360)(360*20) = 50*20
    h = activation_fn(w_gh*g); % (2*50)(50*20) = 2*20
    output_errors = desired_output-h;
    SSE(i) = trace(output_errors'*output_errors);
    
%     print out report every 10 epochs
    if mod(i,10)==0
        message = ['Current Epoch: ',num2str(i), '; SSE: ',num2str(SSE(i))];
        disp(message);
    end
    
    if SSE(i) < 0.01 || i == epoch
        if SSE(i)>=0.01
            disp('Warning: The model does not converge.');
        else
            msg = ['The model converges at the ', num2str(i), 'th epoch.'];
            disp(msg);
        end
        
%         a plot of SSE as it changes through each epoch   
        figure;
        plot(SSE(1:i));
        title('SSE','fontSize',20);
        
%         figure;
%         subplot(1,2,1);
%         imagesc(desired_output);
%         title('Desired Output','fontSize',18);
%         
%         subplot(1,2,2);
%         imagesc(h);
%         title('Obtained Output','fontSize',18);
        break;
    end  
end

% TESTING training set
g = activation_fn(w_fg*patterns);   % (50*360)(360*20) = 50*20
h = activation_fn(w_gh*g); % (2*50)(50*20) = 2*20
round(h)

% TESTING testing set when using raw data
m = activation_fn(w_fg*test_set);   % (50*360)(360*20) = 50*20
n = activation_fn(w_gh*m); % (2*50)(50*20) = 2*20
round(n)
