function h = save_mat2(h_res, h_input)
h = h_res;
h.sus = h_input.sus;
h.eng = h_input.eng;
h.mount = h_input.mount;
h.StiffLocBody = h_input.StiffLocBody;

    %h is handle to input file
% unit_conv = [1e-3*ones(9,1); pi/180 * ones(9,1); 1e3*ones(18,1); 1;1000;1000;1;1];    
% temp = num2cell((res.stage0.x_init ./ unit_conv)');
% size(temp)
%  [h.mount.r_1, h.mount.r_2, h.mount.r_3,...
%                h.mount.o_1, h.mount.o_2, h.mount.o_3,...
%                h.mount.k_l_1, h.mount.k_l_2, h.mount.k_l_3,...
%                h.mount.c_l_1, h.mount.c_l_2, h.mount.c_l_3,...
%                h.mount.m_m, h.mount.k_m, h.mount.c_m,...
%                a,b] = temp{:}; 
%               
% temp = num2cell((res.stage0.lb ./ unit_conv)');
%                [h.mount.lb_r_1, h.mount.lb_r_2,h.mount.lb_r_3,...
%                h.mount.lb_o_1, h.mount.lb_o_2,h.mount.lb_o_3,...
%                h.mount.lb_k_1, h.mount.lb_k_2,h.mount.lb_k_3,...
%                h.mount.lb_c_1, h.mount.lb_c_2,h.mount.lb_c_3,...
%                h.mount.m_m, h.mount.k_m, h.mount.c_m,...
%                a,b] = temp{:};
%            
% temp = num2cell((res.stage0.ub ./ unit_conv)');
%             [h.mount.ub_r_1, h.mount.ub_r_2, h.mount.ub_r_3,...
%                h.mount.ub_o_1, h.mount.ub_o_2, h.mount.ub_o_3,...
%                h.mount.ub_k_1, h.mount.ub_k_2, h.mount.ub_k_3,...
%                h.mount.ub_c_1, h.mount.ub_c_2, h.mount.ub_c_3,...
%                h.mount.m_m, h.mount.k_m, h.mount.c_m,...
%                a,b] = temp{:};
%            
% %% SUSPENSION PARAMETERS %%
% % Ohadi's Data
% % Note: 1 & 4 belong to the front of the vehicle.
% % Note: 1 & 2 belong to the driver side of the vehicle.
% % unsprung mass %
% 
% h.sus.Mu1 = res.stage0.sus.Mu1; h.sus.Mu4 = h.sus.Mu1;  % Front
% h.sus.Mu2 = res.stage0.sus.Mu2; h.sus.Mu3 = h.sus.Mu2;  % Back
% 
% % tires stiffness %
% h.sus.kt1 = res.stage0.sus.kt1;
% h.sus.kt2 = res.stage0.sus.kt1;
% h.sus.kt3 = res.stage0.sus.kt1;
% h.sus.kt4 = res.stage0.sus.kt1;
% 
% % suspension stiffness and damping %
% h.sus.ks1 = res.stage0.sus.ks1;
% h.sus.cs1 = res.stage0.sus.cs1;
% h.sus.ks2 = res.stage0.sus.ks2;
% h.sus.cs2 = res.stage0.sus.cs2;
% h.sus.ks3 = res.stage0.sus.ks3;
% h.sus.cs3 = res.stage0.sus.cs3;
% h.sus.ks4 = res.stage0.sus.ks4;
% h.sus.cs4 = res.stage0.sus.cs4;
% 
% % sprung mass %
% h.sus.Ms = res.stage0.sus.Ms;
% h.sus.Isxx = res.stage0.sus.Isxx;
% h.sus.Isyy = res.stage0.sus.Isyy;
% 
% % axle positions %
% h.sus.Xs1 = res.stage0.sus.Xs1 * 1e3; % m to mm
% h.sus.Ys1 = res.stage0.sus.Ys1 * 1e3; % m to mm
% h.sus.Xs3 = res.stage0.sus.Xs3 * 1e3; % m to mm
% h.sus.Ys3 = res.stage0.sus.Ys3 * 1e3; % m to mm
% h.sus.Xs2 = res.stage0.sus.Xs2 * 1e3; % m to mm
% h.sus.Ys2 = res.stage0.sus.Ys2 * 1e3; % m to mm
% h.sus.Xs4 = res.stage0.sus.Xs4 * 1e3; % m to mm
% h.sus.Ys4 = res.stage0.sus.Ys4 * 1e3; % m to mm
% 
% % engine center of mass in vehicle coordinates %
% h.sus.E_cm = res.stage0.sus.E_cm * 1e3; % m to mm
% 
% %% Engine Properties
% h.eng.mass = res.stage0.eng.mass; %kg
% h.eng.inertia = res.stage0.eng.inertia; %kg.m^2
% h.eng.rpm = res.stage0.eng.rpm / pi/15; %rpm
% rpm = transpose(h.eng.rpm);
% 
% h.eng.torque = res.stage0.eng.torque; %N.m
%  
% % h.eng.M_tilda = res.mount.m_m;
% % h.eng.M = [h.eng.mass*eye(3)  zeros(3,3); zeros(3,3) h.eng.inertia];
% % h.eng.M_e = [h.eng.M, zeros(6,1); zeros(1,6), h.eng.M_tilda];
% 
% %% interpolate local body stiffness
% % 
% % StiffLocBody = res.StiffLocBody;
% % 
% % 
% % rpm_stiff = StiffLocBody.k1(:,1)
% % StiffLocBody.k1(:,2:end)
% % 
% % Temp = interp1(rpm_stiff,StiffLocBody.k1(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.k1 = Temp';
% % Temp = interp1(rpm_stiff,StiffLocBody.k2(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.k2 = Temp';
% % Temp = interp1(rpm_stiff,StiffLocBody.k3(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.k3 = Temp';
% % 
% % Temp = interp1(rpm_stiff,StiffLocBody.c1(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.c1 = Temp';
% % Temp = interp1(rpm_stiff,StiffLocBody.c2(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.c2 = Temp';
% % Temp = interp1(rpm_stiff,StiffLocBody.c3(:,2:end),rpm,'linear','extrap');
% % StiffLocBody.c3 = Temp';
% % 
% % % %% determine optimization parameters
% % % t1 = res.h.t1;  % vector  : 1 for bounded, 0 for fixed
% % % t1(40)=1;
% % % T = eye(41); %transform matrix
% % % T(19:21,19:21)=res.h.t_k1;
% % % T(22:24,22:24)=res.h.t_k2;
% % % T(25:27,25:27)=res.h.t_k3;
% % % T(28:30,19:21)=res.h.t_c1;
% % % T(31:33,22:24)=res.h.t_c2;
% % % T(34:36,25:27)=res.h.t_c3;
% % % T(28:36,28:36) = zeros(9);
% % % % structural constraints has been set
% % % 
% % % t2 = diag(T);   %vector : 1 for independent and 0 for dependent
% % % 
% % % h.t1 = t1;
% % % h.T = T;
% % % h.t2 = t2;
% % 
end