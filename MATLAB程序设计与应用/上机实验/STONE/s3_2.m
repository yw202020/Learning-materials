%if语句实现
function s3_2(x)
if(x>100||x<0)
    disp('输入的成绩不合理')
else
    if(x>=90&&x<=100)
        disp('A')
    elseif(x>=80&&x<90)
        disp('B')
    elseif(x>=70&&x<80)
        disp('C')
    elseif(x>=60&&x<70)
        disp('D')
    elseif(x<60)
        disp('E')
    end;
end


%switch语句实现
% score=input('请输入成绩：');
% if(score>100||score<0)
%     disp('输入的成绩不合理')
% else
%     switch fix(score/10)
%         case{9,10}
%             disp('A')
%         case 8
%             disp('B')
%         case 7
%             disp('C')
%         case 6
%             disp('D')
%         otherwise
%             disp('E')
%     end
% end