%% 文件头

% 欧拉角的旋转正确性测试

%俯仰、横滚、偏航三个旋转顺序是否有要求？

%% 文件头

% @file    test_01.m
% @brief   欧拉角的旋转算法正确性测试
% @details 坐标系为东北天
% @details 俯仰角为机头向上为正；
%          横滚角为右下为正（由后往前看）；
%          航向角机身向右转为正（俯视）
% @details 依次测试三个旋转方向，结果正确
% @author  Adunas
% @date    2024-08-07

%% 三维坐标系绕坐标轴旋转

% 选择单位向量
xa = 1;
ya = 0;
za = 0;

a = [
    xa;
    ya;
    za
];

% 向上仰航 90°
pitch = 0.5 * pi;
roll = 0;
yaw = 0;
b1 = CZ(-yaw)  * CX(pitch) * CY(roll)  * a

% 右下横滚 90°
pitch = 0;
roll = 0.5 * pi;
yaw = 0;
b2 = CZ(-yaw)  * CX(pitch) * CY(roll)  * a

% 向右偏航 90°
pitch = 0;
roll = 0;
yaw = 0.5 * pi;
b3 = CZ(-yaw)  * CX(pitch) * CY(roll)  * a

