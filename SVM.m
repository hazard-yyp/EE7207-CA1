clc;
clear all;
close all;
load('F:\3-Master\EE7207 NEURAL & FUZZY SYSTEMS\CA1\label_train.mat')
load('F:\3-Master\EE7207 NEURAL & FUZZY SYSTEMS\CA1\data_train.mat')
data = data_train;
label = label_train;
temp=randperm(size(data,1));
P_train=data(temp(1:264),:);
T_train=label(temp(1:264),:);
P_validation=data(temp(265:end),:);
T_validation=label(temp(265:end),:);
%net = fitcsvm(P_train,T_train,'OptimizeHyperparameters','auto','KernelFunction','gaussian','KernelScale',12,'BoxConstraint',100,'Standardize',true,'ClassNames',[-1; 1]);
net = fitcsvm(P_train,T_train,'KernelFunction','gaussian','KernelScale',4.0957,'BoxConstraint',18.802,'Standardize',true,'ClassNames',[-1; 1]);
T_predict = predict(net,P_validation);
P_predict = predict(net,P_train);
t_num_mistake=0;
t_num_right=0;
t_TP=0;
t_TN=0;
t_FP=0;
t_FN=0;
for i=1:264
    if P_predict(i)>0
        P_predict(i)=1;
    end
    if P_predict(i)<0
        P_predict(i)=-1;
    end 
    if P_predict(i) ==1 && T_train(i)==1
        t_TP=t_TP+1;
        t_num_right=t_num_right+1;
    end
    if P_predict(i) ==-1 && T_train(i)==-1
        t_TN=t_TN+1;
        t_num_right=t_num_right+1;
    end
    if P_predict(i) ==1 && T_train(i)==-1
        t_FP=t_FP+1;
        t_num_mistake=t_num_mistake+1;
    end
    if P_predict(i) ==-1 && T_train(i)==1
        t_FN=t_FN+1;
        t_num_mistake=t_num_mistake+1;
    end
end
t_pre_P = t_TP/(t_TP+t_FP);
t_rec_P = t_TP/(t_TP+t_FN);
t_pre_N = t_TN/(t_TN+t_FN);
t_rec_N = t_TN/(t_TN+t_FP);
t_acc = t_num_right/(t_num_mistake+t_num_right);
v_num_mistake=0;
v_num_right=0;
v_TP=0;
v_TN=0;
v_FP=0;
v_FN=0;
for i=1:66
    if T_predict(i)>0
        T_predict(i)=1;
    end
    if T_predict(i)<0
        T_predict(i)=-1;
    end
    if T_predict(i) ==1 && T_validation(i)==1
        v_TP=v_TP+1;
        v_num_right=v_num_right+1;
    end
    if T_predict(i) ==-1 && T_validation(i)==-1
        v_TN=v_TN+1;
        v_num_right=v_num_right+1;
    end
    if T_predict(i) ==1 && T_validation(i)==-1
        v_FP=v_FP+1;
        v_num_mistake=v_num_mistake+1;
    end
    if T_predict(i) ==-1 && T_validation(i)==1
        v_FN=v_FN+1;
        v_num_mistake=v_num_mistake+1;
    end
end
v_pre_P = v_TP/(v_TP+v_FP);
v_rec_P = v_TP/(v_TP+v_FN);
v_pre_N = v_TN/(v_TN+v_FN);
v_rec_N = v_TN/(v_TN+v_FP);
v_acc = v_num_right/(v_num_mistake+v_num_right);
load('F:\3-Master\EE7207 NEURAL & FUZZY SYSTEMS\CA1\data_test.mat')
test = data_test;
result = predict(net,test);