% VEP subject symptoms by date post injury
% 0-13 days (acute), 14-29 days (early sub-acute), 30-89 days (late
% subacute), >=90 days (chronic)

load case_data 

time_window=[0 14 30 90 500];

% sx_frequency=table(NaN*ones(4,22),'VariableNames',{'HA_freq' 'nausea_freq' 'balance_freq' ...
%     'dizziness_freq' 'fatigue_freq' 'sleepmore_freq' 'drowsiness_freq' 'senslight_freq'...
%     'sensnoise_freq' 'irritability_freq' 'sadness_freq' 'nervous_freq' 'emotional_freq'...
%     'slowed_freq' 'mentfoggy_freq' 'diffconc_freq' 'diffmem_freq' 'visualprob_freq'...
%     'confused_freq' 'clumsy_freq' 'answslow_freq' 'different_freq'});

% sx_frequency=table([{'acute'};{'early sub-acute'};{'late sub-acute'};{'chronic'}]);
% sx_frequency.Properties.VariableNames{'Var1'}='Timeline';

for x=1:length(time_window)-1
    temp=find(teen_PCSI.dayspostinj>=time_window(x) & ...
        teen_PCSI.dayspostinj<time_window(x+1));
        temp2=find(teen_PCSI(temp,:).teenPCSI_headache>0);
    
    sx_frequency(x,:).HA_freq=length(temp2)/length(temp);
    
    sx_frequency(x,:).nausea_freq=length(find(teen_PCSI(temp,:).teenPCSI_nausea>0))./length(temp);
    prob_HA(x,:).nausea=length(find(teen_PCSI(temp,:).teenPCSI_nausea>0))./length(temp2);
    
    sx_frequency(x,:).senslight_freq=length(find(teen_PCSI(temp,:).teenPCSI_senslight>0))./length(temp);
    prob_HA(x,:).senslight=length(find(teen_PCSI(temp,:).teenPCSI_senslight>0))./length(temp2);
    
    sx_frequency(x,:).sensnoise_freq=length(find(teen_PCSI(temp,:).teenPCSI_sensnoise>0))./length(temp);
    prob_HA(x,:).sensnoise=length(find(teen_PCSI(temp,:).teenPCSI_sensnoise>0))./length(temp2);
    
    sx_frequency(x,:).dizziness_freq=length(find(teen_PCSI(temp,:).teenPCSI_dizziness>0))./length(temp);
    prob_HA(x,:).dizziness=length(find(teen_PCSI(temp,:).teenPCSI_dizziness>0))./length(temp2);
    
    sx_frequency(x,:).balance_freq=length(find(teen_PCSI(temp,:).teenPCSI_balance>0))./length(temp);
    prob_HA(x,:).balance=length(find(teen_PCSI(temp,:).teenPCSI_balance>0))./length(temp2);
    
    sx_frequency(x,:).fatigue_freq=length(find(teen_PCSI(temp,:).teenPCSI_fatigue>0))./length(temp);
    prob_HA(x,:).fatigue=length(find(teen_PCSI(temp,:).teenPCSI_fatigue>0))./length(temp2);
    
    sx_frequency(x,:).sleepmore_freq=length(find(teen_PCSI(temp,:).teenPCSI_sleepmore>0))./length(temp);
    prob_HA(x,:).sleepmore=length(find(teen_PCSI(temp,:).teenPCSI_sleepmore>0))./length(temp2);
    
    sx_frequency(x,:).drowsiness_freq=length(find(teen_PCSI(temp,:).teenPCSI_drowsiness>0))./length(temp);
    prob_HA(x,:).drowsiness=length(find(teen_PCSI(temp,:).teenPCSI_drowsiness>0))./length(temp2);
    
    sx_frequency(x,:).irritability_freq=length(find(teen_PCSI(temp,:).teenPCSI_irritability>0))./length(temp);
    prob_HA(x,:).irritability=length(find(teen_PCSI(temp,:).teenPCSI_irritability>0))./length(temp2);
    
    sx_frequency(x,:).sadness_freq=length(find(teen_PCSI(temp,:).teenPCSI_sadness>0))./length(temp);
    prob_HA(x,:).sadness=length(find(teen_PCSI(temp,:).teenPCSI_sadness>0))./length(temp2);
    
    sx_frequency(x,:).nervous_freq=length(find(teen_PCSI(temp,:).teenPCSI_nervous>0))./length(temp);
    prob_HA(x,:).nervous=length(find(teen_PCSI(temp,:).teenPCSI_nervous>0))./length(temp2);
    
    sx_frequency(x,:).emotional_freq=length(find(teen_PCSI(temp,:).teenPCSI_emotional>0))./length(temp);
    prob_HA(x,:).emotional=length(find(teen_PCSI(temp,:).teenPCSI_emotional>0))./length(temp2);
    
    sx_frequency(x,:).slowed_freq=length(find(teen_PCSI(temp,:).teenPCSI_slowed>0))./length(temp);
    prob_HA(x,:).slowed=length(find(teen_PCSI(temp,:).teenPCSI_slowed>0))./length(temp2);
    
    sx_frequency(x,:).mentfoggy_freq=length(find(teen_PCSI(temp,:).teenPCSI_mentfoggy>0))./length(temp);
    prob_HA(x,:).mentfoggy=length(find(teen_PCSI(temp,:).teenPCSI_mentfoggy>0))./length(temp2);
    
    sx_frequency(x,:).diffconc_freq=length(find(teen_PCSI(temp,:).teenPCSI_diffconc>0))./length(temp);
    prob_HA(x,:).diffconc=length(find(teen_PCSI(temp,:).teenPCSI_diffconc>0))./length(temp2);
    
    sx_frequency(x,:).diffremem_freq=length(find(teen_PCSI(temp,:).teenPCSI_diffremem>0))./length(temp);
    prob_HA(x,:).diffremem=length(find(teen_PCSI(temp,:).teenPCSI_diffremem>0))./length(temp2);
    
    sx_frequency(x,:).visualprob_freq=length(find(teen_PCSI(temp,:).teenPCSI_visualprob>0))./length(temp);
    prob_HA(x,:).visualprob=length(find(teen_PCSI(temp,:).teenPCSI_visualprob>0))./length(temp2);
    
    sx_frequency(x,:).confused_freq=length(find(teen_PCSI(temp,:).teenPCSI_confused>0))./length(temp);
    prob_HA(x,:).confused=length(find(teen_PCSI(temp,:).teenPCSI_confused>0))./length(temp2);
    
    sx_frequency(x,:).clumsy_freq=length(find(teen_PCSI(temp,:).teenPCSI_clumsy>0))./length(temp);
    prob_HA(x,:).clumsy=length(find(teen_PCSI(temp,:).teenPCSI_clumsy>0))./length(temp2);
    
    sx_frequency(x,:).answslow_freq=length(find(teen_PCSI(temp,:).teenPCSI_answslow>0))./length(temp);
    prob_HA(x,:).answslow=length(find(teen_PCSI(temp,:).teenPCSI_answslow>0))./length(temp2);
    
    sx_frequency(x,:).different_freq=length(find(teen_PCSI(temp,:).teenPCSI_different>0))./length(temp);
    prob_HA(x,:).different=length(find(teen_PCSI(temp,:).teenPCSI_different>0))./length(temp2);
    
    
    median_headache(x,:)=nanmedian(teen_PCSI(temp,:).teenPCSI_headache);
    median_total(x,:)=nanmedian(teen_PCSI(temp,:).teenPCSI_score_total);
    median_migraine_fx(x,:)=nanmedian(teen_PCSI(temp,:).migraine_fx);
end

sx_frequency=struct2table(sx_frequency);
prob_HA=struct2table(prob_HA);
