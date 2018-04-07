function normalized_beats = read_beats(data_file,annot_file,symptom,desired_sample_size)
%Sample data_file format: '231m.mat'. Contains raw EKG data.
%Sample annot_file format: 'clean_231.txt'. Contains annotations
%Symptom: numbers from 0 to 8. The kind of sympton the user is looking for
%Start: Input a value >=2. The index for the desired first heartbeat
%Finish: The index for the desired last heartbeat
%Desired_sample_size: The optimal sampling size. eg. 262

%%Import Data
data = load(data_file);
data = cell2mat(struct2cell(data));
% exclude the first and the last heartbeats
data = data(1,:);   

% read in the annotation file, get the sample index of corresponding symptoms
annot = csvread(annot_file);
index = annot(annot(:,3) == symptom,2);
index = index(2:end-1);

%The average heart beat speed PARTICULAR TO THIS PATIENT
avg_beat=round(annot(end,2)/annot(end,1));
look_ahead=round(avg_beat*0.4);
look_behind=avg_beat-look_ahead;

beats = zeros(avg_beat,length(index));

normalized_beats=zeros(desired_sample_size,length(index));


for i=1:length(index)
    beats(:,i)=data(index(i)-look_ahead:index(i)+look_behind-1);
    m = beats(:,i);
    n = numel(m);
    m2 = interp1(1:n, m, linspace(1, n, desired_sample_size/avg_beat*n), 'nearest');
    normalized_beats(:,i)=m2';
end


% average = mean(normalized_beats);
% sd = std(normalized_beats);
% z_score = (normalized_beats-average)./sd;


first_row = normalized_beats(1,:);
normalized_beats = normalized_beats-first_row;

end