% Plot subject demographics and symptoms for case subjects


load VEP_and_subject_data VEPsubject_data

%% clean data

% find control subjects with no family or personal history of migraine
control_loc=find(VEPsubject_data.subjecttype=='Control'...
    & VEPsubject_data.med_hx___1==0 & VEPsubject_data.family_hx___1==0);
control_subjects=VEPsubject_data(control_loc,:);

clear control_loc

% remove duplicate control entries

no_dup=unique(control_subjects.uniqueID(:,1));

for x=1:size(no_dup,1)
    temp_ID=no_dup(x);
    temp_loc=find(control_subjects.uniqueID==temp_ID);
    control_subjects_cleaned(x,:)=control_subjects(temp_loc(1),:);
    clear temp*
end


% remove duplicate case entries
case_loc=find(VEPsubject_data.subjecttype=='Case');
case_subjects=VEPsubject_data(case_loc,:);
unique_case=unique(table2array(case_subjects(:,[1 214])),'rows');

counter1=1;
no_dup=unique(case_subjects.uniqueID(:,1));

for x=1:size(no_dup,1)
    temp_ID=no_dup(x);
    temp_loc=find(case_subjects.uniqueID==temp_ID);
    temp_case=case_subjects(temp_loc,:);
    temp_dpi=unique(temp_case.dayspostinj);
    case_subjects_cleaned(x,:)=case_subjects(temp_loc(1),:);
    for y=1:length(temp_dpi)
        temp_case_dpi=temp_case(find(temp_case.dayspostinj==temp_dpi(y)),:);
        case_sessions_cleaned(counter1,:)=temp_case_dpi(1,:);
        counter1=counter1+1;
    end
    clear temp*
end
    


%% Plot subject demographiscs of control and case subjects

% Sex
figure
subplot(1,3,1)
hold on
case_percentFemale=100*length(find(case_subjects_cleaned.sex_master==1))./length(case_subjects_cleaned.sex_master);
control_percentFemale=100*length(find(control_subjects_cleaned.sex_master==1))./length(control_subjects_cleaned.sex_master);
bar(1,case_percentFemale)
bar(2,control_percentFemale)
[h,p]=ttest2(control_subjects_cleaned.sex_master,case_subjects_cleaned.sex_master);
title(['t test, p=' num2str(p)])
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XTick=[1 2]; ax.XTickLabel={'Case';'Control'};

% Age
subplot(1,3,2)
hold on
histogram(control_subjects_cleaned.age_vep,0:1:18)
plot(median(control_subjects_cleaned.age_vep),25,'bv')
histogram(case_subjects_cleaned.age_vep,0:1:18)
plot(median(case_subjects_cleaned.age_vep),25,'rv')
[h,p]=ttest2(control_subjects_cleaned.age_vep,case_subjects_cleaned.age_vep);
title(['t test, p=' num2str(p)])
ax=gca; ax.TickDir='out'; ax.Box='off';

% percent of case subjects who have personal or family history of migraine
case_percentMedMigraine=100*length(find(case_subjects_cleaned.med_hx___1==1))./length(case_subjects_cleaned.med_hx___1);
case_percentFamilyMigraine=100*length(find(case_subjects_cleaned.family_hx___1==1))./length(case_subjects_cleaned.family_hx___1);
subplot(1,3,3)
hold on
bar(1,case_percentMedMigraine)
bar(2,case_percentFamilyMigraine)
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XTick=[1 2]; ax.XTickLabel={'Personal history';'Family history'};
title('Migraine History')


%% Plot PCSI data
counter1=1;
for x=1:size(case_subjects_cleaned,1)
    temp=find(case_sessions_cleaned.uniqueID==case_subjects_cleaned.uniqueID(x));
    temp2=case_sessions_cleaned(temp,:);
    

    figure(10)
    if isnan(temp2(1,:).childPCSI_score_total)==0
        
        for y=1:size(temp2,1)
            PCSI(counter1,:)=table(temp2(y,:).uniqueID,temp2(y,:).dayspostinj,temp2(y,:).childPCSI_headache,...
                temp2(y,:).childPCSI_senslight,temp2(y,:).childPCSI_sensnoise,temp2(y,:).childPCSI_nausea,...
                temp2(y,:).childPCSI_score_total);
            counter1=counter1+1;
        end
        
        
        subplot(2,5,1)
        hold on
        plot(temp2.dayspostinj,temp2.childPCSI_headache,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,2)
        hold on
        plot(temp2.dayspostinj,temp2.childPCSI_senslight,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,3)
        hold on
        plot(temp2.dayspostinj,temp2.childPCSI_sensnoise,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,4)
        hold on
        plot(temp2.dayspostinj,temp2.childPCSI_nausea,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,5)
        hold on
        plot(temp2.dayspostinj,temp2.childPCSI_score_total,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 120];
        title(num2str(x))
        
    else if isnan(temp2(1,:).teenPCSI_score_total)==0

            
            for y=1:size(temp2,1)
                PCSI(counter1,:)=table(temp2(y,:).uniqueID,temp2(y,:).dayspostinj,temp2(y,:).teenPCSI_headache,...
                temp2(y,:).teenPCSI_senslight,temp2(y,:).teenPCSI_sensnoise,temp2(y,:).teenPCSI_nausea,...
                temp2(y,:).teenPCSI_score_total);
                counter1=counter1+1;
            end
        
        subplot(2,5,1)
        hold on
        plot(temp2.dayspostinj,temp2.teenPCSI_headache,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,2)
        hold on
        plot(temp2.dayspostinj,temp2.teenPCSI_senslight,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,3)
        hold on
        plot(temp2.dayspostinj,temp2.teenPCSI_sensnoise,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,4)
        hold on
        plot(temp2.dayspostinj,temp2.teenPCSI_nausea,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];
        title(num2str(x))
        
        subplot(2,5,5)
        hold on
        plot(temp2.dayspostinj,temp2.teenPCSI_score_total,'-o'...
            ,'MarkerEdgeColor',[0.5 0.5 0.5],'MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.8 0.8 0.8]);
        ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 120];
        title(num2str(x))
        end
    end
end

% plot by chronicity
chronicity_bins=[0 14 30 90 300];
for x=1:length(chronicity_bins)-1
    temp=find(PCSI.Var2>=chronicity_bins(x) & PCSI.Var2<chronicity_bins(x+1));
    
    bootval_headache=bootstrp(1000,@nanmedian,PCSI(temp,:).Var3);
    bootval_headache=sort(bootval_headache);
    headache_M(x,:)=bootval_headache(500,:);
    headache_ERR1(x,:)=bootval_headache(50,:);
    headache_ERR2(x,:)=bootval_headache(950,:);
    
    bootval_senslight=bootstrp(1000,@nanmedian,PCSI(temp,:).Var4);
    bootval_senslight=sort(bootval_senslight);
    senslight_M(x,:)=bootval_senslight(500,:);
    senslight_ERR1(x,:)=bootval_senslight(50,:);
    senslight_ERR2(x,:)=bootval_senslight(950,:);
    
    bootval_sensnoise=bootstrp(1000,@nanmedian,PCSI(temp,:).Var5);
    bootval_sensnoise=sort(bootval_sensnoise);
    sensnoise_M(x,:)=bootval_sensnoise(500,:);
    sensnoise_ERR1(x,:)=bootval_sensnoise(50,:);
    sensnoise_ERR2(x,:)=bootval_sensnoise(950,:);
    
    bootval_nausea=bootstrp(1000,@nanmedian,PCSI(temp,:).Var6);
    bootval_nausea=sort(bootval_nausea);
    nausea_M(x,:)=bootval_nausea(500,:);
    nausea_ERR1(x,:)=bootval_nausea(50,:);
    nausea_ERR2(x,:)=bootval_nausea(950,:);
    
    bootval_total=bootstrp(1000,@nanmedian,PCSI(temp,:).Var7);
    bootval_total=sort(bootval_total);
    total_M(x,:)=bootval_total(500,:);
    total_ERR1(x,:)=bootval_total(50,:);
    total_ERR2(x,:)=bootval_total(950,:);
end


figure(10)
X_val=[7 22 60 110];
subplot(2,5,6)
errorbar(X_val,headache_M,headache_M-headache_ERR1,headache_ERR2-headache_M,'ok','MarkerFaceColor',[0 0 0]);
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];

subplot(2,5,7)
errorbar(X_val,senslight_M,senslight_M-senslight_ERR1,senslight_ERR2-senslight_M,'ok','MarkerFaceColor',[0 0 0]);
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];

subplot(2,5,8)
errorbar(X_val,sensnoise_M,sensnoise_M-sensnoise_ERR1,sensnoise_ERR2-sensnoise_M,'ok','MarkerFaceColor',[0 0 0]);
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];

subplot(2,5,9)
errorbar(X_val,nausea_M,nausea_M-nausea_ERR1,nausea_ERR2-nausea_M,'ok','MarkerFaceColor',[0 0 0]);
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 6];

subplot(2,5,10)
errorbar(X_val,total_M,total_M-total_ERR1,total_ERR2-total_M,'ok','MarkerFaceColor',[0 0 0]);
ax=gca; ax.TickDir='out'; ax.Box='off'; ax.XLim=[0 140]; ax.YLim=[0 120];

save subject_demographics case_sessions_cleaned control_subjects_cleaned